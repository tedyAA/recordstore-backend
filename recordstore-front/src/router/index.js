import Vue from 'vue'
import VueRouter from 'vue-router'
import Artists from "@/views/Artists";
import Records from "@/views/Records";
import Signin from "@/views/Signin";
import Signup from "@/views/Signup";

Vue.use(VueRouter)

const routes = [
  {
    path: '/artists',
    name: 'Artists',
    component: Artists
  },
  {
    path: '/records',
    name: 'Records',
    component: Records
  },
  {
    path: '/signin',
    name: 'Signin',
    component: Signin
  },
  {
    path: '/signup',
    name: 'Signup',
    component: Signup
  }
]

const router = new VueRouter({
  routes
})

export default router
