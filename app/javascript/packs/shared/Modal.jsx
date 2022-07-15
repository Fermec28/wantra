import React from "react";
import styled from 'styled-components';

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
`
const ModalHeaderContainer = styled.div`
height: 45px;
color: white;
border-bottom: ##b5a5d8fc 1px solid;
background-color: #b5a5d8fc
`

const ModalFooterContainer = styled.div`
height: 45px;
border-top: ##b5a5d8fc 1px solid;
display: flex;
color: black;
justify-content: space-evenly;
`

const ModalTitle = styled.p`
padding: 10px;
text-transform: uppercase;
`
const ModalHeader = ({title})=> {
  return(
    <ModalHeaderContainer>
      <ModalTitle>{title}</ModalTitle>
    </ModalHeaderContainer>
  )
}

const ModalFooter = ({onSubmit, onClose})=> {
  return(
    <ModalFooterContainer>
      <button onClick={onSubmit}>SUBMIT</button>
      <button onClick={onClose}>CANCEL</button>
    </ModalFooterContainer>
  )
}

const Modal =  ({children}) => {
	return (
    <OverlayContainer>
      <ModalContainer>
        {children}
      </ModalContainer>
    </OverlayContainer>	
	)
}

Modal.Footer = ModalFooter
Modal.Header = ModalHeader

const BasicModal = ({title, onToggle, onSubmit, children})=>{
  return(
    <Modal>
      <ModalHeader title={title}/>
      {children}
      <ModalFooter onClose={onToggle} onSubmit={onSubmit}/>
    </Modal>
  )
}

export default BasicModal
