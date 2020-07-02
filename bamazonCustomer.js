var mysql = require("mysql")
var inquirer = require("inquirer");

var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "bamazon",
    multipleStatements: true,
});

connection.connect(function(err) {
    if (err) throw err;
    // console.log("Connected as id " + connection.threadId)
    readProducts();
})

var productsArray = []

function readProducts() {
    console.log("Getting inventory...\n")
    connection.query("Select * FROM products", function(err, res){
        if (err) throw err;
        console.log("| Product Name                             | Product Price |")
        console.log("| ---------------------------------------- | ------------- |")
        for (var i=0; i<res.length; i++){
            var products = res[i]
            productsArray.push(products.product_name)
            printRow(products.product_name, products.price)
        }
        promptCustomer()
    })
}

function promptCustomer(){
    console.log("\n")
    inquirer.prompt([
        {
            type: "list",
            name: "userItem",
            message: "What would you like to buy?",
            choices: productsArray
        },
        {
            type: "input",
            name: "userQuantity",
            message: "How many would you like to buy?"
        }
    ]).then(function(results){
        // Use a constructor to pass user input to the placeOrder function
        userOrder = new UserOrder(results.userItem, results.userQuantity)
        placeOrder(userOrder)
    })
}

function placeOrder(userOrder){
    var dataQuery = "SELECT * FROM products WHERE product_name = '" + userOrder.name + "'"
    connection.query(dataQuery, function(err,res){
        if(err) throw err;
        
        quantity = res[0].stock_quantity
        price = res[0].price

        if (quantity - userOrder.quantity < 0) {
            console.log("Insufficient inventory!")
        } 
        else {
            quantity -= userOrder.quantity
            spendings = userOrder.quantity * price
            var updateQuantity = "UPDATE products SET stock_quantity = " + quantity + " WHERE product_name = '" + userOrder.name + "'"
            connection.query(updateQuantity, function(err,res){
                if(err) throw err;
                console.log("Order completed successfully!")
                console.log("You spent: $" + spendings)
            })
            var updateSales = "UPDATE products SET product_sales = product_sales + " + spendings + " WHERE product_name = '" + userOrder.name + "'"
            connection.query(updateSales, function(err,res){
                if(err) throw err;         
            })
        }
        connection.end()
    })
}

function printRow(name, price){
    price = price.toString()
    nameSpaces = 41 - name.length
    priceSpaces = 13 - price.length
    for (var i=0; i<nameSpaces; i++){
        name = name + " "
    }
    for (var j=0; j<priceSpaces; j++){
        price = price + " "
    }
    dispString = "| " + name + "| " + price + " |"
    console.log(dispString)
}

function UserOrder(name, quantity){
    this.name = name
    this.quantity = quantity
}