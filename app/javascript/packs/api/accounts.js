
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
