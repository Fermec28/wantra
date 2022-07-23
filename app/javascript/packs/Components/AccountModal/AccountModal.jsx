
import React from 'react';
import Modal from '../../shared/Modal';
import PropTypes from 'prop-types';


const AccountModal = ({onToggle = ( )=> { }, onSubmit = ( )=> { }})=>{
  return (
    <Modal title="Fer" onToggle={onToggle} onSubmit={onSubmit}>
      <p> test </p>
    </Modal>);
};

AccountModal.propTypes = {
  onToggle: PropTypes.func,
  onSubmit: PropTypes.func,
};

export default AccountModal;
