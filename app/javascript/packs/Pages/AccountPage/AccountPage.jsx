import React, {useState, useEffect} from 'react';
import SideBar from '../../Components/Sidebar/SideBar';
import AccountDetail from '../AccountDetail/AccountDetail';
import {Routes, Route} from 'react-router-dom';
import AccountModal from '../../Components/AccountModal/AccountModal';
import {getAccounts, createAccount} from '../../api/accounts';

const AccountPage = () => {
  const [openModal, setOpenModal] = useState(false);
  const [entities, setEntities] = useState([]);


  useEffect(()=>{
    const handleAccounts = async ()=>{
      const {data, status} = await getAccounts();
      if (status == 200) {
        setEntities(data);
      }
    };
    handleAccounts();
  }, []);

  const handlesubmit = async (values) =>{
    const {data, status} = await createAccount(values);
    if (status == 201) {
      setEntities((entities)=> [...entities, data]);
    }
  };

  const toogleModal = () => setOpenModal((isOpen) => !isOpen);
  return (
    <div className="flex-grow flex overflow-x-hidden">
      <SideBar onClick={toogleModal} entities={entities}/>
      <Routes>
        <Route path="/:accountId" element={<AccountDetail />} />
      </Routes>
      <AccountModal
        isOpen={openModal}
        onToggle={toogleModal}
        onSubmit={handlesubmit}
      />
    </div>
  );
};

export default AccountPage;
