//
//  MapView.swift
//  Hedonist
//
//  Created by a.lobanov on 12/24/22.
//

import UIKit
import SnapKit
import MapKit
import CoreLocation

protocol MapViewProtocol: AnyObject {
    func displayLandmarks(viewModel: [Landmark])
    func displayLandmark(viewModel: Landmark)
}


final class CustomAnnotation: MKPointAnnotation {
    var landmark: Landmark
    
    init(landmark: Landmark) {
        self.landmark = landmark
        super.init()
    }
}


final class MapView: UIView {
    // MARK: - Variable
    var interactor: MapInteractorProtocol?
    var router: MapRouterProtocol?
    
    private var model: [Landmark]?
    
    
    // MARK: - UI Variable
    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.layer.masksToBounds = true
        let location = CLLocationCoordinate2D(latitude: DefaultLocation.latitude, longitude: DefaultLocation.longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: DefaultLocation.zoom, longitudinalMeters: DefaultLocation.zoom)
        map.setRegion(region, animated: false)
        return map
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - UI
    private func layoutUI() {
        backgroundColor = .systemBackground
        
        addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}


extension MapView: MapViewProtocol {
    // MARK: - Implementation
    func displayLandmarks(viewModel: [Landmark]) {
        model = viewModel
        
        DispatchQueue.main.async {
            self.model?.forEach { landmark in
                let annotation = CustomAnnotation(landmark: landmark)
                annotation.title = landmark.name
                annotation.subtitle = landmark.category
                annotation.coordinate = CLLocationCoordinate2D(latitude: landmark.lat ?? 0.0, longitude: landmark.long ?? 0.0)
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    
    func displayLandmark(viewModel: Landmark) {
        let landmark = viewModel
        router?.openLandmark(landmark: landmark)
    }
}


extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        guard let annotation = annotation as? CustomAnnotation else { return }
        let landmark = annotation.landmark
        interactor?.selectLandmark(request: landmark)
    }
}
