var mysql = require("mysql")
var inquirer = require("inquirer");

var connection = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "bamazon"
});

connection.connect(function(err) {
    if (err) throw err;
    console.log("Connected to as id " + connection.threadId)
    promptManager()
})

function promptManager(){

    inquirer.prompt([
        {
            type: "list",
            name: "managerAction",
            message: "What would you like to do?",
            choices: ["View Products for Sale", "View Low Inventory", "Add to Inventory", "Add New Product", "Exit"],
        }
    ]).then(function(res){
        var mgrChoice = res.managerAction
        switch(mgrChoice) {
            case "View Products for Sale":
                viewProducts()
                break;
            case "View Low Inventory":
                lowInventory()
                break;
            case "Add to Inventory":
                addInventory()
                break;
            case "Add New Product":
                newProduct()
                break;
            case "Exit":
                connection.end()
                break;
            }   
    })
}

function viewProducts(){
    console.log("Getting inventory...\n")
    connection.query("SELECT * FROM products", function(err, res){
        if (err) throw err;
        tableHeader();
        for (var i=0; i<res.length; i++){
            var products = res[i]
            printRow(products.id, products.product_name, products.department_name, products.price, products.stock_quantity)
            
        }
        console.log("\n")
        promptManager();
    })
}

function lowInventory(){
    console.log("Finding low inventory...\n")
    connection.query("SELECT * FROM products", function(err, res){
        if (err) throw err;
        // console.log(res)
        tableHeader();
        for (var i=0; i<res.length; i++){
            var products = res[i]
            if (products.stock_quantity <= 5){
                printRow(products.id, products.product_name, products.department_name, products.price, products.stock_quantity)
            }
        }
        console.log("\n")
        promptManager();
    })


}

function addInventory(){

}

function newProduct(){

}



function tableHeader(){
    console.log("| ID | Product Name                             | Department Name              | Product Price | Quantity |")
    console.log("| -- | ---------------------------------------- | ---------------------------- | ------------- | -------- |")
}


function printRow(id, name, department, price, quantity){
    price = price.toString()
    id = id.toString()
    quantity = quantity.toString()

    nameSpaces = 40 - name.length
    priceSpaces = 13 - price.length
    idSpaces = 2 - id.length
    departmentSpaces = 28 - department.length
    quantitySpaces = 8 - quantity.length

    for (var h=0; h<idSpaces; h++){
        id = id + " "
    }

    for (var i=0; i<nameSpaces; i++){
        name = name + " "
    }

    for (var j=0; j<priceSpaces; j++){
        price = price + " "
    }

    for (var k=0; k<departmentSpaces; k++)
        department = department + " "

    for (var l=0; l<quantitySpaces; l++){
        quantity = quantity + " "
    }


    dispString = "| " + id + " | " + name + " | " + department + " | " + price + " | " +  quantity + " |"
    console.log(dispString)
}

