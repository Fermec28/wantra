import React from "react";
import CardAccount from "../CardAccount/CardAccount";


const cards = [
    {name: "Kathyrn Murphy", ammount:"$1,902.00", img:"https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=046c29138c1335ef8edee7daf521ba50"},
    {name: "Mert Cukuren", ammount:"$2,794.00", img:"https://assets.codepen.io/344846/internal/avatars/users/default.png?fit=crop&format=auto&height=512&version=1582611188&width=512"},
    {name: "Albert Flores", ammount:"$0.00", img:"https://images.unsplash.com/photo-1541647376583-8934aaf3448a?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"},
    {name: "Jane Cooper", ammount:"$762.00", img:"https://images.unsplash.com/photo-1519699047748-de8e457a634e?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&ixid=eyJhcHBfaWQiOjE3Nzg0fQ"},
    {name: "Ronald Richards", ammount:"$0.00", img:"https://images.unsplash.com/photo-1507120878965-54b2d3939100?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=200&w=200&s=99fbace66d1bfa48c9c6dc8afcac3aab"}
]

const SideBar = () => {
    return(
        <div class="xl:w-72 w-48 flex-shrink-0 border-r border-gray-200 dark:border-gray-800 h-full overflow-y-auto lg:block hidden p-5">
        <div class="text-xs text-gray-400 tracking-wider">ACCOUNTS</div>
        <div class="relative mt-2">
          {
          //<!-- search input-->
          }
          <input type="text" class="pl-8 h-9 bg-transparent border border-gray-300 dark:border-gray-700 dark:text-white w-full rounded-md text-sm" placeholder="Search" />
          <svg viewBox="0 0 24 24" class="w-4 absolute text-gray-400 top-1/2 transform translate-x-0.5 -translate-y-1/2 left-2" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <circle cx="11" cy="11" r="8"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
        </div>
        <div class="space-y-4 mt-3">
            {cards.map((card)=> <CardAccount {...card}/>)}
        </div>
      </div>
    )
}

export default SideBar;