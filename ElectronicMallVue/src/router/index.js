/*
 * @Description: 
 * @Author: ly
 * @Date: 2023-03-26 15:27:05
 */
import Vue from 'vue'
import VueRouter from 'vue-router'
import request from '../utils/request';


Vue.use(VueRouter)
//requireAuth: 是否需要检查登录
const routes = [
    //前台
  {
    path: '/',
    name: 'front',
    redirect: "/topview",
    component: () => import('../views/front/Front.vue'),
    meta: {title:'CarpetIT', path: 'CarpetIT', requireAuth: false},
    children: [
      {path: 'person', name: 'person', meta: {title:'Personal Information',requireLogin: true}, component: () => import('../views/Person.vue'),},
      {path: 'topview', name: 'topview', meta: {title:'CarpetIT'}, component: () => import('../views/front/TopView.vue'),},
      {path: 'cart', name: 'cart', meta: {title:'MyCart',requireLogin: true}, component: () => import('../views/front/good/Cart.vue'),},
      {path: 'goodList', name: 'goodList', meta: {title:'ProductList'}, component: () => import('../views/front/good/GoodList.vue'),},
      {path: 'goodView/:goodId', name: 'goodview', meta: {title:'ProductDetails'}, component: () => import('../views/front/good/GoodView.vue'),},
      {path: 'preOrder', name: 'preOrder', meta: {title:'ConfirmOrder',requireLogin: true}, component: () => import('../views/front/order/PreOrder.vue'),},
      {path: 'pay', name: 'pay', meta: {title:'Payment',requireLogin: true}, component: () => import('../views/front/order/Pay.vue'),},
      {path: 'orderList', name: 'orderList', meta: {title:'MyOrder',requireLogin: true}, component: () => import('../views/front/order/OrderList.vue'),},

    ]
  },
    //后台
  {
    path: '/manage',
    name: 'manage',
    component: () => import('../views/manage/Manage.vue'),
    redirect: "/manage/home",
    meta: {title:'Backend', path: 'backend',requireAuth: true},
    children: [
      {path: 'home', name: 'home', meta: {title:'home', path: 'home',requireAuth: true}, component: () => import('../views/manage/Home.vue'),},
      {path: 'user', name: 'user', meta: {title:'user',path: 'system/user',requireAuth: true}, component: () => import('../views/manage/User.vue'),},
      {path: 'person', name: 'person', meta: {title:'person',path: 'person',requireAuth: true}, component: () => import('../views/Person.vue'),},
      {path: 'file', name: 'file', meta: {title:'file',path: 'file/file management',requireAuth: true}, component: () => import('../views/manage/file/File.vue'),},
      {path: 'avatar', name: 'avatar', meta: {title:'avatar',path: 'file/avatar management',requireAuth: true}, component: () => import('../views/manage/file/Avatar.vue'),},
      {path: 'carousel', name: 'carousel', meta: {title:'carousel',path: 'product/carousel',requireAuth: true}, component: () => import('../views/manage/good/Carousel.vue'),},
      {path: 'category', name: 'category', meta: {title:'category',path: 'product/category',requireAuth: true}, component: () => import('../views/manage/good/Category.vue'),},
      {path: 'good', name: 'good', meta: {title:'product',path: 'product/product management',requireAuth: true}, component: () => import('../views/manage/good/Goods.vue'),},
      {path: 'goodInfo', name: 'goodInfo', meta: {title:'product',path: 'product/product management/info',requireAuth: true}, component: () => import('../views/manage/good/GoodInfo.vue'),},
      {path: 'order', name: 'order', meta: {title:'order',path: 'product/order',requireAuth: true}, component: () => import('../views/manage/Order.vue'),},
      {path: 'incomeChart', name: 'incomeChart', meta: {title:'income chart',path: 'revenue/income chart',requireAuth: true}, component: () => import('../views/manage/income/IncomeChart.vue'),},
      {path: 'incomeRank', name: 'incomeRank', meta: {title:'income rank',path: 'revenue/income rank',requireAuth: true}, component: () => import('../views/manage/income/IncomeRank.vue'),},

    ]
  },
  {
    path: '/login',
    name: 'login',
    meta: {
      title: 'login',
      requireAuth: false,
    },
    component: () => import(/* webpackChunkName: "about" */ '../views/Login.vue')
  },
  {
    path: '/register',
    name: 'register',
    meta: {
      title: 'register',requireAuth: false,
    },
    component: () => import(/* webpackChunkName: "about" */ '../views/Register.vue')
  },
  {
    path: '/*',
    name: 'notFound',
    meta: {
      title: 'Could not find the page'
    },
    component: () => import(/* webpackChunkName: "about" */ '../views/404NotFound.vue')
  },
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

//beforeEach是router的钩子函数，在进入路由前执行
router.beforeEach((to, from, next) => {
  // if(to.path === '/manage'){
  //   let user = localStorage.getItem("user");
  //   if(!user.token){
  //     next('/login');
  //   }
  // }
  let role;
  let allow = false;
  if(to.meta.requireAuth===true){
    //在后台获得该用户的身份
    request.post("http://localhost:9191/role").then(res=>{
      if(res.code==='200'){
        role = res.data;
        console.log('Your role: '+role);
        if(role === 'admin'){
          allow = true;
        }
        else if(role==='user'){
            alert("You are not authenticated:(");
            allow = false;
            next("/")
        }
      }
      else{  //查询身份失败
        alert(res.msg);
        next('/login');
      }
      //放行
      if(allow === true){
        //设置网页title
        if (to.meta.title) {
          document.title = to.meta.title
        } else {
          document.title ='Unknown Page'
        }
        next()
      }
    }
    )
  }
  else{    //不需要判断权限
    if(to.meta.requireLogin===true){
      if(!isLogin()){
        next('/login');
      }
    }
    if (to.meta.title) {
      document.title = to.meta.title
    } else {
      document.title ='Unknown Page'
    }
    next()
  }

})

function isLogin() {
  let user = localStorage.getItem("user");
  if(user){
    return true;
  }else{
    return false;
  }
}
export default router
