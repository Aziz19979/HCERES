import axios from "axios";

const authToken = (token) => {
  axios.defaults.baseURL = 'http://localhost:9000/';
  if (token) {
    axios.defaults.headers.common["Authorization"] = `${token}`;
  } else {
    delete axios.defaults.headers.common["Authorization"];
  }
};

export default authToken;
