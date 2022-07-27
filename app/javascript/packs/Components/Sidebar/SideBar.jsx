/* eslint-disable max-len */
import React, {useEffect, useState} from 'react';
import CardAccount from '../CardAccount/CardAccount';
import {getAccounts} from '../../api/accounts';
import styled from 'styled-components';
import PropTypes from 'prop-types';


const SideBarContainer = styled.div`
width: 18rem;
display: block;
padding: 1.25rem;
border-right-width: 1px;
flex-shrink: 0;
height: 100%;
display: flex;
flex-direction: column;
justify-content: space-between; 
`;


const SideBarHeaderContainer = styled.div`
border-bottom-width: 1px;
padding: 0.7rem;
`;

const SideBarBodyContainer = styled.div`
height: 100%;
overflow-y: scroll;
`;
const SideBarFooterContainer = styled.div`
height: 2rem;
padding: 0.7rem;
text-align: center;
border-top-width: 1px;
`;

const SideBar = ({onClick=()=>{}}) => {
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

  return (
    <>
      <SideBarContainer>
        <SideBarHeaderContainer>
          <h3> ACCOUNTS </h3>
          <div className="relative mt-2">
            {
            // <!-- search input-->
            }
            <input type="text" className="pl-8 h-9 bg-transparent border border-gray-300 dark:border-gray-700 dark:text-white w-full rounded-md text-sm" placeholder="Search" />
            <svg viewBox="0 0 24 24" className="w-4 absolute text-gray-400 top-1/2 transform translate-x-0.5 -translate-y-1/2 left-2" stroke="currentColor" strokeWidth="2" fill="none" strokeLinecap="round" strokeLinejoin="round">
              <circle cx="11" cy="11" r="8"></circle>
              <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
            </svg>
          </div>
        </SideBarHeaderContainer>
        <SideBarBodyContainer>
          <div className="space-y-4 mt-3">
            {entities.map((card)=> <CardAccount key={card.id} {...card} />)}
          </div>
        </SideBarBodyContainer>
        <SideBarFooterContainer>
          <button onClick={onClick}> Add Acount</button>
        </SideBarFooterContainer>
      </SideBarContainer>
    </>

  );
};

SideBar.propTypes ={
  onClick: PropTypes.func,
};

export default SideBar;
