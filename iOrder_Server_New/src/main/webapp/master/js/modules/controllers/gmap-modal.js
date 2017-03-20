/**=========================================================
 * Module: modals.js
 * Provides a simple way to implement bootstrap modals from templates
 =========================================================*/

App.controller('ModalGmapController', ['$scope', '$modal', '$timeout', function ($scope, $modal, $timeout) {

  $scope.open = function (size) {

    var modalInstance = $modal.open({
      templateUrl: '/myModalContent.html',
      controller: ModalInstanceCtrl,
      size: size
    });
  };

  // Please note that $modalInstance represents a modal window (instance) dependency.
  // It is not the same as the $modal service used above.

  var ModalInstanceCtrl = function ($scope, $modalInstance, $timeout) {

    $modalInstance.opened.then(function () {
      var position = new google.maps.LatLng(33.790807, -117.835734);

      $scope.mapOptionsModal = {
        zoom: 14,
        center: position,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };

      // we use timeout to wait maps to be ready before add a markers
      $timeout(function(){
        // 1. Add a marker at the position it was initialized
        new google.maps.Marker({
          map: $scope.myMapModal,
          position: position
        });
        // 2. Trigger a resize so the map is redrawed 
        google.maps.event.trigger($scope.myMapModal, 'resize');
        // 3. Move to the center if it is misaligned
        $scope.myMapModal.panTo(position);
      });

    });

    $scope.ok = function () {
      $modalInstance.close('closed');
    };

    $scope.cancel = function () {
      $modalInstance.dismiss('cancel');
    };

  };
  ModalInstanceCtrl.$inject = ["$scope", "$modalInstance", "$timeout"];

}]);
