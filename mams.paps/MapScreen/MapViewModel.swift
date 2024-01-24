

import Foundation
import YandexMapsMobile

protocol MapViewModelProtocol: AnyObject {
    func didTapPlacemark(name: String, coordinates: (latitude: Double, longitude: Double))
}

final class MapViewModel {
    weak var delegate: MapViewModelProtocol?

    @objc func zoomIn() {
        // Логика увеличения зума
    }

    @objc func zoomOut() {
        // Логика уменьшения зума
    }

    @objc func moveToPlacemark() {
        // Логика перемещения к метке
        delegate?.didTapPlacemark(name: "Example Placemark", coordinates: (54.707590, 20.508898))
    }

    @objc func moveToPolyline() {
        // Логика перемещения к линии
    }

    // Дополнительные методы для работы с данными и обновления ViewModel
}
