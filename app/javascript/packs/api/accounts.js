
import {API_ROUTE} from '../constants';


export const getAccounts = async ()=> {
  const response = await fetch(
      `${API_ROUTE}/accounts`,
      {
        method: 'GET',
      },
  );
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  const data = await response.json();
  return {data, status: response.status};
};

export const createAccount = async (values)=>{
  const response = await fetch(
      `${API_ROUTE}/accounts`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({account: values}),
      },
  );
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  const data = await response.json();
  return {data, status: response.status};
};
