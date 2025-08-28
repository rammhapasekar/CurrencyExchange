//
//  ExchangeRateStoreTests.swift
//  CurrencyExchange-MVI
//
//  Created by RamUttam Mhapasekar on 28/08/2025.
//
import XCTest
import Combine
@testable import CurrencyExchange

let mockCurrencies: [Currency] = [
    Currency(code: "USD",
             name: "US Dollar",
             country: "United States",
             countryCode: "US",
             flag: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAALESURBVHja7Jc/aBNxFMc/l0STtqYtihgkYLOYitjuFuwiUgfBUOgSOqS6CNqmRRqLmyjBBDQ4FLRL/TOokEEhgyC4O7RSB0MHWxEtWLGtrW2Su/s9h8ZeUlF7rV4XHzy+995v+d77vnf3fpqIsJ3mYpvtPwENcAPeMjppJlD0APXHj9/44nZvrhh3d45tsvYuAk9GdwM0nTiRkZmZb3L9+jPbuBUDmjyA1zAUIyMviMXaSaVzDPSfJJ3O0V+JqRz9A1acSufQgC+XrlpvJRXCVua06nNXYz36m0kArwtAKUVPTzvJ5FPifR0kk0/pW4/x6jje10GhoEOhaHmx7OtzP50XQDfWOIbb2lISjz+SqakFicVGN4yx2OhWJQh7AAzDJB7vYHDwEclkF4nExnBo6DGz3Rfs959/F8aHGQDKBBSJxEOuXeuit/cemUz3hhBA6d82NfxSKlkStLZekcnJeTl2LC35/Jwt/CsS6LpJT88d7oycJRod5sH9c0Sjw9z/A4Lw8egp0MptLmI9V8br8prPB8WCJYGuK27fPkPk9E2y2T5ORzJks71EIqtxZC2uznd23kJ8y9Vj9zv7MZKGjlROQSg0JKHQZZmYmJVgMLFhDAYTW5YAIBwMJmR8/JPU1Z2XsTF7OL3nkH0PtMj7g20ChDUgHAhczC8tlTAM03ZD52ue258CjwfNX8eBty+bNSBsmmbe5XL2z6yUwu12N3sApve34jFMpKQ7swPs3IGxw2NNgTINRARRpv1tQtbFld3+q3VT3CjTsAgE34/j8/kclWBlZQVqa1cJTO89TI3XiyyvOCNBbQ3LpaK1E5pKVX/B/jkDDaWkQoKPr2hoaHBUgoWFBWhsXCXwLtBCY73fUQJzXxfXKmDqfpPPMu8oAfEDBUwN2AccAfY6vJbPAq+18p3AX0YnrQgsav8vp9tN4PsALYQJa7MTgzkAAAAASUVORK5CYII="),
    Currency(code: "EUR", name: "Euro", country: "European Union", countryCode: "EU", flag: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAASdSURBVHja7JdbbFRFGMd/c85uu+32sl1aSqul5WqLRYwsVsLVkpqgQEKIF5IafSBeIxijRjQEEiKRiNUH6wUe1IAmRtTEEBuKTURMNaJI5VJuBkyBLV267ZalezlnZnzYpd1tfTBtsrzwPZzvzJxv5vzn/13yjdBaczPF4CbLLQACMIHspM6kSCDmAAqsQ+3BE0VTaHqnhSuXA4CLrS8toOKzj0EILjQ+xZb3fgY0peUenpwqWVrhZLlVOXbqhaBl3RKvAyj8rfUI81eYNO9Yww/tFzhzsgtvqZechXWAwDvJS/2yWUwrz2FRfoSJU8u4UjKZ+s7LYwZwwh8CKHQA2Zs6DDbODOM738bK+fM4WJSH0grrSgAQaGC2R7LIFcQ55x5+9Ev27TmAXjANjR7l0xvPG98EApLvGijKySImJUC2A2DTOh+e8mJUrsbuCVA/t5r41SBXBwbBMKjymEz1lWHcfhthkYU72kXjylns6hkc0+kjlsRSCUAOgJrdH+CsrSEWChMVBlh70VqhYxYAvU0fQXYW2rIRaKZkOXAhifhWjQlAlmkQl2oYgD0QxugbwA72oxAYpomyLEhWSTkYSVDpdGJohTQFUiiux+3/kWSjK61pCGw7BUDX0y/icGUxZcYkCkyN6O7Gdrvxb20CBGVbXsZVOoHIyXMM5BTwTzBGFpLrF6NjzH2RzsAzW9t44bWV1BiaeMt+9gVc1DT48NoxBCaneiWXAiEenOih/7sDHO7N56vTUfTyO9I2bm5vprfExApDQYHAjoDM0eT7JRsWPj9kp9BEUhl4v7mRhaKbrk++YGe3h5bjfpru6qMkGgHDQV9PiM1v7efo2kWsf3Q1z7W1UqMjvDrCBdaci3gqTJxakePPI2bHcLtNLEukuUtpjaVSANzb0cZPp/t5+1wuZ892AQ4MQyMGB8EwMQWEw5rdu1o5/MsZXt+4gvrKTsJ/pgMwC5fS3zlARV4huuUQvYun83dHnHCVRTg2bGtJhSVTsqC6rwxKyrAmKKirAmDtsV5oeDaxovMqNPoA+ANY03L0P337YTBOIHadhyZXs+pSlK7ZK9hwchvL8u9PYyBuGzhMMQzAUppwzMZKBsZYZc3MGYjcYibmeAkF/MwrLqdp8WNU1/r4vLV/yM5pGhS6nClpaEtsrZDjbE7u2/EpodggWimi7ly6H3+CeS4vqD3IhzcPZ4FWxG2ZwoDUaAVKjQ/ANw13Ule7BCMYxHhzOyVN73LZbqf3mhvVM7y3FgI7ybYBIKWN1onoVGmalLEeMa9H2X9btYDiR1bjfqABonHsuyvpmf4l30+uTVujNVhJBowbUQmJD1qnap0yZsQ8o+z3Xcxj58FTFDlM3IbBXyd+5+tzG9n+qyNtDWikTHGBLSWmaaLQ4+5v3jh4nr3tg7wyt5ptHdkcxwPGiJIswFL2MAApJeYQuvE3WUfibtbWrR+eGrmvBpmsAwaAUgohROb6QCFQKiUGtFZk8P8IkTj0kAu01gggP9GfZER0SkMi0ZproVCGm2INIAVQCswGSjKMIAAcE8k7QX5SZ1JiwDVx63J6swH8OwAzn1iX8pdbIgAAAABJRU5ErkJggg=="),
    Currency(code: "JPY", name: "Yen", country: "Japan", countryCode: "JP", flag: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAAJHSURBVHja7JfPaxNBFMc/s9lkk5Kmra0kelFbJJUiiAqKpaBQ8OhB8SIIgid78OLBq4f+A0UPIoh4VLyK6EHBQpWChypUUhV/IP6qCWzTTTbdnefBVNNizVRi9tIvDMvCzJvv+773Zt4oESFKWESMDQIKiAFO/dtOhIBvAxkRKUbivVKbLKArwgh0WXX5o4ITeRLa/7RKhLBYZOn1WwiWiA/0Y/X1omKx/08g+PCR0sRlgvfvUChAIYTEevvoHhsjMTS47jLMi8hLk8nVqWnmxy9hkfjDESJofLpPnyF98rhpFQwaKxB8+szXixeIkUII1/SmeGWCeP8OnP17W6iACF9OnaVWmAXigNSXSoMZ6v8ay0my9dE9VNxujQLh/Heqz54CSaC66hRvJPOTSFguUpt5gbNvT2uS0H8yjV6soAhMy4TFu/dbR0B7HrpUQpEwJKCRctm8DEUEpdSak5Ijh5CwZly1Go/U0dEmaSW/A9msK7K35HAGhhDtg9ZNRoAV6yA1fMCcgNa6WcGSvX0Trb2mBEK9QPbGNZTz9ytmeU8zAkBiV57c1esE4iISIKJXjYBAXHrOnSd94ljzMDXsma9UKmKKyuSUvNm2UwoqIXMqLXOqUwoqIa96cuLeumNsx/M8AfK2qQK/EnL4INtnZ6g8nsR78BDxfTpGj5A6PIKVyRjbWaGA67rSbriuK0DeWq8CrcKKJIzicbJMwAZCrTWlUqmtBOpOhwrIAruBzW0W4RvwXNWb0s4ImlMfWFAbj9OoCfwYAOvZ37XX6A+0AAAAAElFTkSuQmCC")
]

final class ExchangeRateStoreTests: XCTestCase {
    var store: ExchangeRateStore!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        store = ExchangeRateStore()
        cancellables = []
    }

    override func tearDown() {
        store = nil
        cancellables = nil
        super.tearDown()
    }

    func testCurrencyFiltering() {
        store.injectCurrencies(mockCurrencies)
        store.dispatch(.searchChanged("jap"))

        XCTAssertEqual(store.state.filteredCurrencies.count, 1)
        XCTAssertEqual(store.state.filteredCurrencies.first?.country, "Japan")
    }

    func testAmountChange() {
        store.dispatch(.amountChanged("99.5"))
        XCTAssertEqual(store.state.amount, "99.5")
    }

    func testSelectCurrencyUpdatesTarget() {
        store.injectCurrencies(mockCurrencies)
        store.dispatch(.selectCurrency(code: "JPY"))
        XCTAssertEqual(store.state.targetCurrency, "JPY")
    }

    func testFetchExchangeRate_withInvalidAmount_shouldFail() {
        store.dispatch(.amountChanged("abc"))
        store.dispatch(.convert)

        XCTAssertEqual(store.state.result, nil)
        XCTAssertEqual(store.state.error, "Invalid amount")
    }

    // Mock async test example
    func testFetchExchangeRate_withValidMockedData() {
        store.injectCurrencies(mockCurrencies)
        store.injectTargetCurrency("EUR")
        store.injectAmount("100")

        let expectation = XCTestExpectation(description: "Wait for API")

        // You would normally mock the API layer here
        store.dispatch(.convert)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Should be updated only if API key is working, or mock injected
            XCTAssert(self.store.state.error == nil || self.store.state.result != nil)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
