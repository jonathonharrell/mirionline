'use strict'

angular.module 'mirionlineApp'
.factory 'Static', ($modal) ->

  open: (page, callback) ->
    $modal.open
      templateUrl: 'components/static/' + page + '.html'
      size: 'lg'
      resolve: callback
