<template>
  <div class="container has-text-centred mt-5 p-5">
    <p class="title is-size-4 has-text-link">Sign up</p>
    <input class="input" v-model="email" type="text" placeholder="Enter email">
    <input class="input mb-3 mt-3" type="text" v-model="password" placeholder="Enter password">
    <input class="input" type="text" v-model="password_confirmation" placeholder="Repeat password">
    <button class="button is-link mt-5" @click="signup">Sign up</button>
    <p class="has-text-centered mt-3">or</p>
    <button class="button is-link mt-3" @click="goToSignin">Log in</button>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    goToSignin(){
      this.$router.replace('/signin')
    },
    signup () {
      const requestOptions = {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ email: this.email, password: this.password, password_confirmation: this.password_confirmation })
      };
      fetch("http://127.0.0.1:3000/signup", requestOptions)
          .then(response => this.signupSuccessful(response))
          .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signupFailed (error) {
      console.log(error)
      this.error = (error.response && error.response.data && error.response.data.error) || 'Sng'
      alert("Couldn't sign up");
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
<style>
.container{
  width: 30%;
  box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
}
</style>
