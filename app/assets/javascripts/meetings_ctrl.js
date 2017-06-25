/* global angular */
(function(){
  angular.module("app").controller("meetingsCtrl", function($scope, $http){
    
    $scope.setup = function () {
      $http.get("/api/v1/meetings.json").then(function(response){
        $scope.meetings = response.data;
      });
      $http.get("/api/v1/tags.json").then(function(response){
        $scope.tags = response.data;
      });
    };

    $scope.orderByAttribute = function(attribute) {
      if(attribute !== $scope.orderAttribute) {
        $scope.descending = false;
      } else {
        $scope.descending = !$scope.descending;
      }
      $scope.orderAttribute = attribute;
    };

    $scope.filterByTag = function(tag) {
      $scope.tagFilterId = tag.id;
      console.log($scope.tagFilterId);
    };

    $scope.matchTag = function(meeting) {
      if($scope.tagFilterId) {
        // use a for loop to see if $scope.tagFilterId exists in meeting.tags
        for (var i =0; i < meeting.tags.length; i++){
          var currentTag = meeting.tags[i];
          if(currentTag.id == $scope.tagFilterId) {
            return true;
          }
        }
        return false;
      } else
      return true;
    };

    $scope.createMeeting = function(name, address, startTime, endTime, notes, tags) {
      var newMeeting = {
        name: name,
        address: address,
        start_time: startTime,
        end_time: endTime,
        notes: notes,
        tags: tags
      };
      $http.post("/api/v1/meetings.json", newMeeting).then(function(response){
        console.log(response);
        $scope.meetings.push(response.data);
      }, function(error){
        console.log(error);
      });
    };

  });
}());









