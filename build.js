({
    baseUrl: './js',
    name: 'main',
    out: 'js/dist/main.js',
    removeCombined: true,
    include: ["requireLib"],
    paths: {
        text:           'vendor/text',
        jquery:         'vendor/jquery.min',
        underscore:     'vendor/underscore.min',
        backbone:       'vendor/backbone.min',
        bootstrap:      'vendor/bootstrap.min',
        templates:      '../templates',
        collections:    './collections',
        models:         './models',
        views:          './views',
        requireLib:     'vendor/require.min'
    }
})