/**=========================================================
 * Module: rickshaw.js
 =========================================================*/

App.controller('ChartRickshawController', ['$scope', function($scope) {
  'use strict';

  $scope.renderers = [{
          id: 'area',
          name: 'Area'
      }, {
          id: 'line',
          name: 'Line'
      }, {
          id: 'bar',
          name: 'Bar'
      }, {
          id: 'scatterplot',
          name: 'Scatterplot'
      }];

  $scope.palettes = [
      'spectrum14',
      'spectrum2000',
      'spectrum2001',
      'colorwheel',
      'cool',
      'classic9',
      'munin'
  ];

  $scope.rendererChanged = function(id) {
      $scope['options' + id] = {
          renderer: $scope['renderer' + id].id
      };
  };

  $scope.paletteChanged = function(id) {
      $scope['features' + id] = {
          palette: $scope['palette' + id]
      };
  };

  $scope.changeSeriesData = function(id) {
      var seriesList = [];
      for (var i = 0; i < 3; i++) {
          var series = {
              name: 'Series ' + (i + 1),
              data: []
          };
          for (var j = 0; j < 10; j++) {
              series.data.push({x: j, y: Math.random() * 20});
          }
          seriesList.push(series);
          $scope['series' + id][i] = series;
      }
      //$scope['series' + id] = seriesList;
  };

  $scope.series0 = [];

  $scope.options0 = {
    renderer: 'area'
  };

  $scope.renderer0 = $scope.renderers[0];
  $scope.palette0 = $scope.palettes[0];

  $scope.rendererChanged(0);
  $scope.paletteChanged(0);
  $scope.changeSeriesData(0);  

  // Graph 2

  var seriesData = [ [], [], [] ];
  var random = new Rickshaw.Fixtures.RandomData(150);

  for (var i = 0; i < 150; i++) {
    random.addData(seriesData);
  }

  $scope.series2 = [
    {
      color: "#c05020",
      data: seriesData[0],
      name: 'New York'
    }, {
      color: "#30c020",
      data: seriesData[1],
      name: 'London'
    }, {
      color: "#6060c0",
      data: seriesData[2],
      name: 'Tokyo'
    }
  ];

  $scope.options2 = {
    renderer: 'area'
  };


}]);
