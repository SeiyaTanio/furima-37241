function calculate (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener('keyup', () => {
    const priceVal = itemPrice.value;
    const taxPrice = document.getElementById("add-tax-price");
    const taxCal = priceVal * 0.1
    taxPrice.innerHTML = `${taxCal}`;
    const profit = document.getElementById("profit");
    profit.innerHTML = `${priceVal - taxCal}`;
  });
};

window.addEventListener('load', calculate)