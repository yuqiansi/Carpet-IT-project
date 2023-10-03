const express = require('express')
const app = express()
const exphbs = require('express-handlebars')
const mongoose = require("mongoose");
const bodyParser = require("body-parser")
var USERNAME;
var MongoClient = require('mongodb').MongoClient;

const url = "mongodb+srv://yusi1:SYQsyq20000726@cluster0.3yrd0kh.mongodb.net/Cluster0"
mongoose.connect("mongodb+srv://yusi1:SYQsyq20000726@cluster0.3yrd0kh.mongodb.net/Cluster0");



app.use(bodyParser.urlencoded({extended: false}))

const noteSchema = new mongoose.Schema( {
    username: String,
    password: String,
    cpassword: String
})



const Note = mongoose.model("Note",noteSchema)


app.post("/signUp",function(req,res){
    if (req.body.password == req.body.cpassword){
        
        MongoClient.connect(url,{useNewUrlParser:true},function (err,client) {
            if(err){
                throw err;
            }
            var db = client.db();
            console.log(req.body.username)
            var result = db.collection('notes').find({username:req.body.username});
            result.toArray(function (err,arr) { 
                if(err){
                    throw err;
                }
                console.log(arr.length)
                //username is not registered
                if (arr.length == 0){
                    let newNote = new Note({
                        
                        username: req.body.username,
                        password: req.body.password,
                
                    });
                
                newNote.save();
                res.redirect("/login");
                console.log("sucessful to sign up");
                }
                //Username has already been registered
                else{
                    res.redirect("/signUp-nameError")
                    console.log("username had been occued");
                }
            })
            }
            )
    }else{//password is different from confirm password
        console.log("password not match")
    }})

    app.post("/signUp-nameError",function(req,res){
        if (req.body.password == req.body.cpassword){
            MongoClient.connect(url,{useNewUrlParser:true},function (err,client) {
                if(err){
                    throw err;
                }
                var db = client.db();
                var result = db.collection('notes').find({username:req.body.username})
                result.toArray(function (err,arr) {
                    if(err){
                        throw err;
                    }
                    console.log(arr.length)
                    if (arr.length == 0){
                        let newNote = new Note({
                            username: req.body.username,
                            password: req.body.password,
                    
                        });
                    
                    newNote.save();
                    res.redirect("/login");
                    console.log("sucessful to sign up");
                    }
                    else{
                    res.redirect("/signUp-nameError")
                    console.log("username had been occued");
                    }
                })
                }
                )
        }else{
            console.log("password not match")
        }})


//login-error
app.post("/login-error",function(req,res){
    console.log("i am in log-error in page")
    
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        var db = client.db();
        var result = db.collection('notes').find({username:req.body.username});
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            console.log("my data here");
            //Username does not exist
            if (arr.length == 0){
                console.log("ohhh you have not been sign up yet")
                res.redirect("/login-error")
            }else{
                var textpassword = (arr[0]["password"]).toString();
                var passwordinput = req.body.password.toString();
                
                //successfully sign in
                if (textpassword == passwordinput){
                    console.log("you are able to log in")
                    res.redirect("/guide");
                }else{
                    //Password does not match
                    res.redirect("/login-error")
                    console.log("you got wrong passport")
                }
            }
        })    
    })
})

// handle login page
app.post("/login",function(req,res){
    console.log("i am in log in page")
    
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        var db = client.db();
        var result = db.collection('notes').find({username:req.body.username});
        USERNAME = req.body.username;
       
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            //Username does not exist
            if (arr.length == 0){
                res.redirect("/login-error")
            }else{
                var textpassword = (arr[0]["password"]).toString();
                var passwordinput = req.body.password.toString();
                
           
                if (textpassword == passwordinput){
                    //successfully sign in
                    res.redirect("/guide");
         

                }else{
                    //Password does not match
                    res.redirect("/login-error")
                    console.log("you got wrong passport")
                }
            }
        })    
    })
})
//change password
app.post("/changePassword",function(req,res){
    console.log("i am in log in page")
    
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        console.log('database link successfully in login page ');
        
        var db = client.db();
        var result = db.collection('notes').find({username:req.body.username});
        
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            console.log("my data here");
            //username not valid
            if (arr.length == 0){
                res.redirect("/changePassword-error")
                console.log("ohhh you have not been sign up yet")
            }else{
                var username = req.body.username.toString();
                var textpassword = (arr[0]["password"]).toString();
                var passwordinput = req.body.password.toString();
                var newPassword = req.body.npassword.toString();
                var newConPassword = req.body.cnpassword.toString();               
                //username match with old password
                if (textpassword == passwordinput){
                    console.log("you are able to change password");
                    //new password same as confirm password
                    if(newPassword == newConPassword){
                        
                        var thenote = db.collection('notes');
                        
                        aim = {"username":username}
                        
                        thenote.deleteMany(aim);
                        let newNote = new Note({ 
                            username: username,
                            password: newPassword,
                        });
                        newNote.save();
                        res.redirect("/guide");
                    }

                }else{
                    res.redirect("/changePassword-error")
                    console.log("you got different password")
                }
            }
        })    
    })
})



app.post("/changePassword-error", function(req,res){
    console.log("i am in log in page")
    
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        console.log('database link successfully in login page ');
        
        var db = client.db();
        var result = db.collection('notes').find({username:req.body.username});
        
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            console.log("my data here");
            //username not valid
            if (arr.length == 0){
                
                res.redirect("/changePassword-error");
                console.log("ohhh you have not been sign up yet");
            }else{
                var username = req.body.username.toString();
                var textpassword = (arr[0]["password"]).toString();
                var passwordinput = req.body.password.toString();
                var newPassword = req.body.npassword.toString();
                var newConPassword = req.body.cnpassword.toString();               
                //username match with old password
                if (textpassword == passwordinput){
                    console.log("you are able to change password");
                    //new password same as confirm password
                    if(newPassword == newConPassword){
                        
                        var thenote = db.collection('notes');
                        
                        aim = {"username":username}
                        
                        thenote.deleteMany(aim);
                        let newNote = new Note({ 
                            username: username,
                            password: newPassword,
                        });
                        newNote.save();
                        res.redirect("/guide");
                    }
                    //new password does not go with confirm password
                    else{
                        res.redirect("/changePassword-error");
                    }
                }else{
                    //username does not match with password
                    res.redirect("/changePassword-error");
                    console.log("you got different password");
                }
            }
        })    
    })
})
app.post("/found",function(req,res){
    console.log("i am in found page!!!!!")
    var key = req.body.searchFind.toString();
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        console.log('database link successfully in login page ');
        
        var db = client.db();
        var result = db.collection('founds').find(  {$or : [{"item":{ $regex:key}}, {"description":{$regex:key}}]})
        
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            var posts = []
            if (arr.length == 0){
                res.render('found', { 
                    css: 'found.css',
                    dataRows: posts,
                })
            }else{             
                for (var i in arr) {
                    var post = {}
                    post['item'] = arr[i]['item']
                    post['location'] = arr[i]['where']
                    post['time'] = arr[i]['when']
                    post['picture'] = arr[i]['picture']
                    post['description'] = arr[i]['description']
                    post['contactName'] = arr[i]['contactName']
                    post['phoneNum'] = arr[i]['phoneNum']
                    post['email'] = arr[i]['email']
                    post['username'] = arr[i]['username']
                    posts.push(post)
                }
                res.render('found', { 
                    css: 'found.css',
                    dataRows: posts,
                })
            }
        })    
    })

})



app.post("/lost", function(req,res){
    console.log("i am in lost page!!!!!")
    var key = req.body.searchFind.toString();
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        console.log('database link successfully in login page ');
        
        var db = client.db();
        var result = db.collection('losts').find({$or : [{"item":{ $regex:key}}, {"description":{$regex:key}}]})
        
        result.toArray(function (err,arr) {
            if(err){
                throw err;
            }
            var posts = []
            if (arr.length == 0){
                res.render('lost', { 
                    css: 'lost.css',
                    dataRows: posts,
                })
            }else{             
                for (var i in arr) {
                    var post = {}
                    post['item'] = arr[i]['item']
                    post['location'] = arr[i]['where']
                    post['time'] = arr[i]['when']
                    post['picture'] = arr[i]['picture']
                    post['description'] = arr[i]['description']
                    post['contactName'] = arr[i]['contactName']
                    post['phoneNum'] = arr[i]['phoneNum']
                    post['email'] = arr[i]['email']
                    post['username'] = arr[i]['username']
                    posts.push(post)
                }
                res.render('lost', { 
                    css: 'lost.css',
                    dataRows: posts,
                })
            }
        })    
    })

})

const lostSchema = new mongoose.Schema( {
    item: String,
    where: String,
    when: String,
    picture: String,
    description : String,
    contactName : String,
    phoneNum: String,
    email: String,
    username: String
})

const foundSchema = new mongoose.Schema( {
    item: String,
    where: String,
    when: String,
    picture: String,
    description : String,
    contactName : String,
    phoneNum: String,
    email: String,
    username: String
})


var Lost = mongoose.model("lost",lostSchema)
var Found = mongoose.model("found",foundSchema)


const language = {
    set current(name){
        this.log.push(name);
    },
    dele(){
        this.log.splice(0);
        this.log.length = 0
    },
    log:[]
};


app.get('/mypost',  function(req,res){ 
    MongoClient.connect(url,{useNewUrlParser:true},function (err,client) {
    if(err){
        throw err;
    }
     
    var db = client.db()
    var resultfind =  db.collection('founds').find({username:USERNAME})
    var resultlost = db.collection("losts").find({username:USERNAME})

    var rows = []
    rows.splice(0)
    language.dele()
 


    resultlost.toArray(function (err,arr)  {
        if(err){
            throw err
        }
        else {
            
            for (var i in arr){
                var row = {}
                row['_id'] = arr[i]['_id']
                row['item'] = arr[i]['item']
                row['location'] = arr[i]['where']
                row['time'] = arr[i]['when']
                row['description'] = arr[i]['description']
                row['contactName'] = arr[i]['contactName']
                row['phoneNum'] = arr[i]['phoneNum']
                row['email'] = arr[i]['email']
                row['picture'] = arr[i]['picture']
                rows.push(row)
            }
            resultfind.toArray(function (err,arrfind)  {
                if(err){
                    throw err
                }
                else {        
                    for (var i in arrfind) {
                        var row = {}
                        row['_id'] = arrfind[i]['_id']
                        row['item'] = arrfind[i]['item']
                        row['location'] = arrfind[i]['where']
                        row['time'] = arrfind[i]['when']
                        row['description'] = arrfind[i]['description']
                        row['contactName'] = arrfind[i]['contactName']
                        row['phoneNum'] = arrfind[i]['phoneNum']
                        row['email'] = arrfind[i]['email']
                        row['picture'] = arrfind[i]['picture']
                        rows.push(row)
                    }
                }
            return res.render('mypost', { 
                css: 'mypost.css',
                dataRows: rows,
            })})
              
        }
    } )
    
})
     
})



app.post("/report",function(req,res){
    console.log("i am in report page")
     
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err;
        }
        console.log('report page connected');
        var db = client.db();
        if(req.body.lost_items){
        let newLost = new Lost({
            item: req.body.item,
            where: req.body.where,
            when: req.body.when,
            picture: req.body.itemImage,
            description :req.body.description,
            contactName : req.body.contactName,
            phoneNum: req.body.phoneNum,
            email: req.body.email,
            username: USERNAME
        });
        newLost.save();      
        res.redirect("/lost");
        //If edited, delete original post
        if(thedata){
            deletePost(thedata)
            thedata = null
        }
        console.log("sucessful to upload lost post");}
        else {
            let newFound = new Found({
                item: req.body.item,
                where: req.body.where,
                when: req.body.when,
                description :req.body.description,
                picture: req.body.itemImage,
                contactName : req.body.contactName,
                phoneNum: req.body.phoneNum,
                email: req.body.email,
                username: USERNAME
            });
            newFound.save();
            //If edited, delete original post
            if(thedata){
                deletePost(thedata)
                thedata = null
            }      
            res.redirect("/found");
            console.log("sucessful to upload found post"); 
        }
          
    })
})

//delete
app.post("/:item_id/delete",function(req,res){
    console.log('successfully delete')
    deletePost(req.params.item_id)
    res.redirect("/guide")
})

//delete post from database
function deletePost(id){
    MongoClient.connect(url,{useNewUrlParser:false},function (err,client) {
        if(err){
            throw err
        }
        var db = client.db();
        var ObjectID = require('mongodb').ObjectID;
                        
        db.collection('losts').deleteMany({'_id':ObjectID(id)});
        db.collection('founds').deleteMany({'_id':ObjectID(id)});
    })

}
var thedata;
//edit posts
app.post("/:item_id/edit", function(req,res){
        thedata = req.params.item_id
        res.redirect("/report")
})


const PORT = process.env.PORT || 3000
const allRouter = require('./routes/allRouter')

app.engine('hbs', exphbs.engine({
    defaultlayout: 'main',
    extname: 'hbs'
}))
app.set('view engine', 'hbs')

app.use(express.static(__dirname + '/public'))



//app post 
app.listen(PORT, () => {
    console.log('The library app is running!')
})



app.use('/', allRouter)


