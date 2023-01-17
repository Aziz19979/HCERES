import {Oval} from "react-loading-icons";
import React from "react";

const LoadingIcon = (props) => {
    const color = props.color ? props.color: "rgb(1, 127, 255";
    return <Oval className="mr-2" width={20} height={20} stroke={color}/>
}


export default LoadingIcon;