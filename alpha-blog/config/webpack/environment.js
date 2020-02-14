const { environment } = require('@rails/webpacker')
//recommended for rails 6?
// const webpack = require('webpack')
// enviroment.plugins.append('Provide', 
// 	new webpack.ProvidePlugin({
// 		$: 'jquery',
// 		jquery: 'jquery'
// 		Popper: ['popper.js', 'default']
// 	})
module.exports = environment
