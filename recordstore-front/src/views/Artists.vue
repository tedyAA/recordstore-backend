<template>
  <div class="container">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add a new artist</h3>
    <form action="" @submit.prevent="addArtist">
      <div class="mb-6">
        <input class="input"
               autofocus autocomplete="off"
               placeholder="Type an arist name"
               v-model="newArtist"/>
      </div>
      <b-button @click="addArtist">Add artist</b-button>
    </form>

    <hr class="border border-grey-light my-6"/>

    <ul class="list-reset mt-4">
      <li class="py-4" v-for="artist in artists" :key="artist.id" :artist="artist">

        <div class="flex items-center justify-between flex-wrap">
          <p class="block flex-1 font-mono font-semibold flex items-center ">
            <svg class="fill-current text-indigo w-6 h-6 mr-2" viewBox="0 0 20 20" width="20" height="20"><title>music
              artist</title>
              <path
                  d="M15.75 8l-3.74-3.75a3.99 3.99 0 0 1 6.82-3.08A4 4 0 0 1 15.75 8zm-13.9 7.3l9.2-9.19 2.83 2.83-9.2 9.2-2.82-2.84zm-1.4 2.83l2.11-2.12 1.42 1.42-2.12 2.12-1.42-1.42zM10 15l2-2v7h-2v-5z"></path>
            </svg>
            {{ artist.name }}
          </p>

          <button
              class="bg-tranparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 mr-2 rounded"
              @click.prevent="editArtist(artist)">Edit
          </button>

          <button
              class="bg-transprent text-sm hover:bg-red text-red hover:text-white no-underline font-bold py-2 px-4 rounded border border-red"
              @click.prevent="removeArtist(artist)">Delete
          </button>
        </div>

        <div v-if="artist == editedArtist">
          <form action="" @submit.prevent="updateArtist(artist)">
            <div class="mb-6 p-4 bg-white rounded border border-grey-light mt-4">
              <input class="input" v-model="artist.name"/>
              <input type="submit" value="Update"
                     class=" my-2 bg-transparent text-sm hover:bg-blue hover:text-white text-blue border border-blue no-underline font-bold py-2 px-4 rounded cursor-pointer">
            </div>
          </form>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>

import axios from "axios";

export default {
  name: 'Artists',
  data() {
    return {
      artists: [],
      newArtist: '',
      error: '',
      editedArtist: ''
    }
  },
  created() {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    } else {
      const requestOptions = {
        method: "GET"
      };
      fetch("http://127.0.0.1:3000/api/v1/artists", requestOptions)
          .then(response => response.json())
          .then(response => {
            this.artists = response.data
          })
          .catch(error => this.setError(error, 'fsdfsdf'))
    }
  },
  methods: {
    setError(error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addArtist() {
      const value = this.newArtist
      if (!value) {
        return
      }
      axios({
        method: 'post',
        url: 'http://127.0.0.1:3000/api/v1/artists',
        headers: { Authorization: `Bearer ${this.$store.state.jwt}` },
       data:{
         artist:{name: this.newArtist}
       }
      })
          .then(response => response.json())
          .then(response => {
            this.artists.push(response.data)
            this.newArtist = ''
          })
          .catch(error => this.setError(error, 'Cannot create artist'))
    },
    removeArtist(artist) {
      this.$http.secured.delete(`/api/v1/artists/${artist.id}`)
          .then(response => {
            console.log(response)
            this.artists.splice(this.artists.indexOf(artist), 1)
          })
          .catch(error => this.setError(error, 'Cannot delete artist'))
    },
    editArtist(artist) {
      this.editedArtist = artist
    },
    updateArtist(artist) {
      this.editedArtist = ''
      this.$http.secured.patch(`/api/v1/artists/${artist.id}`, {artist: {title: artist.name}})
          .catch(error => this.setError(error, 'Cannot update artist'))
    }
  }
}
</script>
<style>
.container {
  width: 30%;
  box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
}
</style>
