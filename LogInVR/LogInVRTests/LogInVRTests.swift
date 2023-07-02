//
//  LogInVRTests.swift
//  LogInVRTests
//
//  Created by Uri on 2/7/23.
//

import XCTest
@testable import LogInVR

final class LogInVRTests: XCTestCase {
    var sut: LoginViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testLogin_ValidateTextFields_AreEmpty() throws {
        let email = try XCTUnwrap(sut.emailTextField)
        let password = try XCTUnwrap(sut.passwordTextField)
        
        XCTAssertEqual(email.text, "", "emailTextField should be empty")
        XCTAssertEqual(password.text, "", "passwordTextField should be empty")
    }
    
    func testLogin_EmailTextFieldKeyboardType_ShouldBe_EmailAddress() throws {
        let email = try XCTUnwrap(sut.emailTextField)
        
        XCTAssertEqual(email.keyboardType, .emailAddress, "email keyboardType should be .emailAddress")
    }
    
    func testLogin_PasswordTextField_ShouldBe_SecureTextEntry() throws {
        let password = try XCTUnwrap(sut.passwordTextField)
        
        XCTAssertTrue(password.isSecureTextEntry, "passwordTextField should have secure text entry")
    }    
}
