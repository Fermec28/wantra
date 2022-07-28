import React from 'react';
import styled from 'styled-components';
import PropTypes from 'prop-types';

const OverlayContainer = styled.div`
position: fixed;
width: 100%;
height: 100%;
top: 0;
left: 0;
right: 0;
bottom: 0;
background-color: rgb(81 51 188 / 55%);
z-index: 2;
display: flex;
align-items: center;
text-align: center;
justify-content: center;
`;

const ModalContainer = styled.div`
width: 45vw;
height: 70vh;
background-color: white;
display: flex;
flex-direction: column;
justify-content: space-between;
`;
const ModalHeaderContainer = styled.div`
height: 45px;
color: white;
border-bottom: ##b5a5d8fc 1px solid;
background-color: #b5a5d8fc
`;

const ModalFooterContainer = styled.div`
height: 45px;
border-top: ##b5a5d8fc 1px solid;
display: flex;
color: black;
justify-content: space-evenly;
`;

const ModalTitle = styled.p`
padding: 10px;
text-transform: uppercase;
`;


const ModalBody = styled.div`
overflow-y: scroll;
margin-top: 1rem;
`;
const ModalHeader = ({title})=> {
  return (
    <ModalHeaderContainer>
      <ModalTitle>{title}</ModalTitle>
    </ModalHeaderContainer>
  );
};

ModalHeader.propTypes = {
  title: PropTypes.string.isRequired,
};

const ModalFooter = ({onSubmit = ()=> {}, onClose = ()=> {}})=> {
  return (
    <ModalFooterContainer>
      <button onClick={onClose}>CANCEL</button>
      <button type="submit" onClick={onSubmit}>SUBMIT</button>
    </ModalFooterContainer>
  );
};

ModalFooter.propTypes = {
  onSubmit: PropTypes.func,
  onClose: PropTypes.func,
};

const Modal = ({children}) => {
  return (
    <OverlayContainer>
      <ModalContainer>
        {children}
      </ModalContainer>
    </OverlayContainer>
  );
};

Modal.propTypes = {
  children: PropTypes.node.isRequired,
};

Modal.Footer = ModalFooter;
Modal.Header = ModalHeader;
Modal.Body = ModalBody;

const BasicModal = ({
  title,
  onToggle=()=>{},
  onSubmit=()=>{},
  children=()=>{},
})=>{
  return (
    <Modal>
      <ModalHeader title={title}/>
      <ModalBody>
        {children}
      </ModalBody>
      <ModalFooter onClose={onToggle} onSubmit={onSubmit}/>
    </Modal>
  );
};

BasicModal.propTypes = {
  title: PropTypes.string.isRequired,
  onToggle: PropTypes.func,
  onSubmit: PropTypes.func,
  children: PropTypes.node.isRequired,
};

export default Modal;
