'use strict'

angular.module 'mirionlineApp'
.factory 'Static', ($modal) ->

  open: (page) ->
    $modal.open
      templateUrl: 'components/static/' + page + '.html'
      size: 'lg'
    .result
