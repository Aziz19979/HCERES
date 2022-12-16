import React from 'react';
import {FooterBody, FooterText, AboutImg} from './FooterElements'
import AboutLogo from '../../assets/about.svg';
import authToken from "../../utils/authToken";

const Footer = () => {
    authToken(localStorage.jwtToken);
    return (
        <div>
            {/*To allow more scrolling area on the page */}
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <br/>
            <FooterBody className={"fixed-bottom"}>
                <div className="text5"></div>
                <div className="text2">
                    <FooterText> ©2021 - CRTI - Ecole Centrale Nantes - France </FooterText>
                </div>
                <div className="footer1">
                    <AboutImg to="/About">
                        <img src={AboutLogo} alt="about" width='auto'/>
                    </AboutImg>
                </div>
            </FooterBody>
        </div>
    );
};

export default Footer;