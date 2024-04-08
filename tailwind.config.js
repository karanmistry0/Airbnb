/** @type {import('tailwindcss').Config} */
const colors = require("tailwindcss/colors");
module.exports = {
  content: ["./app/**/*.{html,js,erb}"],
  theme: {
    colors: {
      ...colors,
      primary:{
        DEFAULT: '#FF5A5F',
        dark: '#ff385c'
      }
    },
    extend: {},
  },
  plugins: [
  ],
}

