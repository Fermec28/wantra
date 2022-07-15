// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import Header from './Components/Header/Header'
import AccountPage from './Pages/AccountPage/AccountPage'
import { BrowserRouter, Routes, Route } from "react-router-dom";

const Hello = props => (
  <div className="bg-gray-100 dark:bg-gray-900 dark:text-white text-gray-600 h-screen flex overflow-hidden text-sm">
    <div className="flex-grow overflow-hidden h-full flex flex-col">
      <BrowserRouter >
        <Header />
        <Routes>
          <Route path="/accounts/*" element={<AccountPage />} />
        </Routes>      
      </BrowserRouter>
    </div>
  </div>
)

Hello.defaultProps = {
  name: 'David'
}

Hello.propTypes = {
  name: PropTypes.string
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <Hello name="React" />,
    document.body.appendChild(document.createElement('div')),
  )
})
