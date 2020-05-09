module.exports = {
  plugins: [
    require('postcss-import'),
    require('postcss-flexbugs-fixes'),
    require('postcss-preset-env')({
      autoprefixer: {
        flexflex-box: 'no-2009'
      },
      stage: 3
    })
  ]
}
