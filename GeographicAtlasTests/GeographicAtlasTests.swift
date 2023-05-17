//
//  GeographicAtlasTests.swift
//  GeographicAtlasTests
//
//  Created by Alua Sayabayeva on 2023-05-17.
//

import XCTest
import Alamofire
@testable import GeographicAtlas

final class GeographicAtlasTests: XCTestCase {
    

    var countryManager: CountryManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        countryManager = CountryManager()
    }

    override func tearDownWithError() throws {
        countryManager = nil
    }

    func testFetchCountry() {
        let expectation = XCTestExpectation(description: "Fetch Country")
            
        class MockDelegate: CountryManagerDelegate {
            var onCountryModelDidUpdateCalled = false
            var countryModel: CountryModel?

            func onCountryModelDidUpdate(with model: CountryModel) {
                onCountryModelDidUpdateCalled = true
                countryModel = model
            }
        }

        let mockDelegate = MockDelegate()
        countryManager.delegate = mockDelegate

        let cca2 = "KZ"
        let urlString = "https://restcountries.com/v3.1/alpha/\(cca2)"
            
        AF.request(urlString).responseDecodable(of: [CountryModel].self) { response in
            switch response.result {
            case .success(let model):
                mockDelegate.onCountryModelDidUpdate(with: model[0])
            case .failure(let error):
                XCTFail("API request failed with error: \(error)")
            }
                
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)

        XCTAssertTrue(mockDelegate.onCountryModelDidUpdateCalled)
        XCTAssertNotNil(mockDelegate.countryModel)
        
        let countryModel = mockDelegate.countryModel
        XCTAssertEqual(countryModel?.name.common, "Kazakhstan")
    }
}
