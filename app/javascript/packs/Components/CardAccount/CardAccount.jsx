import React from "react";

const CardAccount = ({name, ammount, img})=> {
    return(
        <button class="bg-white p-3 w-full flex flex-col rounded-md dark:bg-gray-800 shadow">
        <div class="flex xl:flex-row flex-col items-center font-medium text-gray-900 dark:text-white pb-2 mb-2 xl:border-b border-gray-200 border-opacity-75 dark:border-gray-700 w-full">
          <img src={img} className="w-7 h-7 mr-2 rounded-full" alt="profile" />
          {name}
        </div>
        <div class="flex items-center w-full">
          <div class="text-xs py-1 px-2 leading-none dark:bg-gray-900 bg-blue-100 text-blue-500 rounded-md">Design</div>
          <div class="ml-auto text-xs text-gray-500">{ammount}</div>
        </div>
      </button>
    )
}

export default CardAccount