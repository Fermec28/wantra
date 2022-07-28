
import React from 'react';
import Modal from '../../shared/Modal';
import PropTypes from 'prop-types';
import {Formik, Field, Form} from 'formik';
import styled from 'styled-components';

const InputContainer = styled.div`
border: 1px solid rgba(0,0,0,.12);
border-radius: 8px;
padding-left: 1rem;
padding-top: 1rem;
margin-left: 1rem;
margin-right: 1rem;
margin-bottom: 1rem;
display: flex;
flex-direction: column;
align-items: flex-start;

input, textarea, select{
  margin-top: 0.5rem;
  margin-bottom: 0.5rem;
  width: 100%;
  border:none;
  
  &:focus{
    outline: none;
  }
}
`;


const AccountModal = ({isOpen, onToggle = ( )=> { }, onSubmit = ( )=> { }})=>{
  return (isOpen &&
    <Modal title="New Account" onToggle={onToggle}>
      <Modal.Header title="New Account" onToggle={onToggle}/>
      <Formik
        initialValues={{
          name: '',
          description: '',
          currency_id: '23',
          total_amount: 0,
        }}
        onSubmit={(values) =>{
          onSubmit(values);
          onToggle();
        }}
      >
        <Form>
          <Modal.Body>
            <InputContainer>
              <label htmlFor="name">Name</label>
              <Field id="name" name="name" placeholder="My Account" />
            </InputContainer>

            <InputContainer>
              <label htmlFor="description">Description</label>
              <Field id="description" name="description"
                placeholder="Description"
                as="textarea" rows="2"/>
            </InputContainer>

            <InputContainer>
              <label htmlFor="email">Currency</label>
              <Field
                id="currency_id"
                name="currency_id"
                as= "select"
              >
                <option value={23}> $COP Colombia Peso</option>
                <option value={33}>€EUR Euro Member Countries </option>
                <option value={106}>$USD United States Dollar</option>
              </Field>
            </InputContainer>
            <InputContainer>
              <label htmlFor="total_amount">Initial Amount</label>
              <Field id="total_amount" name="total_amount" placeholder="0"
                type="number"/>
            </InputContainer>
          </Modal.Body>
          <Modal.Footer onClose={onToggle}/>
        </Form>
      </Formik>
    </Modal>);
};

AccountModal.propTypes = {
  isOpen: PropTypes.bool,
  onToggle: PropTypes.func,
  onSubmit: PropTypes.func,
};

export default AccountModal;
