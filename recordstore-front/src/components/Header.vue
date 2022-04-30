<template>
  <nav class="navbar" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item">
        <img src="../assets/record.png" width="28" height="28"> Record Store
      </a>

      <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false" data-target="navbarBasicExample">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div id="navbarBasicExample" class="navbar-menu has-text-left">
      <div class="navbar-start m-0 ">
        <b-button class="navbar-item " @click="goToSignArtists">
          Artists
        </b-button>

        <a class="navbar-item" @click="goToSignRecords">
          Records
        </a>
      </div>

      <div class="navbar-end has-text-right mr-0">
        <div class="navbar-item">
          <div v-if="!this.$store.state.signedIn" class="buttons">
            <a class="button is-primary" @click="goToSignUp">
              <strong>Sign up</strong>
            </a>
            <a class="button is-light" @click="goToSignIn">
              Log in
            </a>
          </div>
          <b-button class="button is-primary" @click="signOut" v-if="this.$store.state.signedIn">Sign out</b-button>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import axios from "axios";

export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    goToSignIn(){
      this.$router.replace('/signin')
    },
    goToSignUp(){
      this.$router.replace('/signup')
    },
    goToSignArtists(){
      this.$router.replace('/artists')
    },
    goToSignRecords(){
      this.$router.replace('/records')
    },
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      axios({
        method: 'delete',
        url: 'http://127.0.0.1:3000/signin',
        headers: { Authorization: `Bearer ${this.$store.state.jwt}` },
      })
          .then(response => {
            console.log(response)
            delete this.$store.state.csrf
            delete this.$store.state.jwt
            this.$store.state.signedIn = false
            this.$router.replace('/signin')
          })
          .catch(error => this.setError(error, 'Cannot sign out'))

    }
  }
}
</script>
