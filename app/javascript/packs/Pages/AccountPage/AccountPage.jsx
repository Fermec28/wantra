import React from 'react';
import SideBar from '../../Components/Sidebar/SideBar';
import AccountDetail from '../AccountDetail/AccountDetail';
import {Routes, Route} from 'react-router-dom';

const AccountPage = () => {
  return (
    <div className="flex-grow flex overflow-x-hidden">
      <SideBar />
      <Routes>
        <Route path="/:accountId" element={<AccountDetail />} />
      </Routes>
    </div>
  );
};

export default AccountPage;
