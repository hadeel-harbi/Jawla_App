class ApiALl
    with
        AuthEndpoint,
        ConstApi,
        UserEndpoint,
        ActivityEndpoint,
        OwnerEndpoint {}

mixin ConstApi {
  String url = "0.0.0.0:8080";
}

mixin AuthEndpoint {
  String createAccount = "/auth/create_account";
  String loginAccount = "/auth/login";
  String forgetPassword = "/auth/forget_password";
  String updatePassword = "/auth/update_password";
}

mixin UserEndpoint {
  String displayActivity = "/user/display_all_activities";
  String addFavorite = "/user/add_favorite/";
  String displayFavorite = "/user/display_favorites";
  String user = "user/display_profile";
  String editProfile = "user/edit_profile";
  String addOwner = "user/upgrade_to_owner";

  String displayReservations = "/user/display_reservations";
  String displayReservationsByDate = "/user/display_reservations_by_date/";
  String addReservation = "/user/add_reservation/";
}

mixin ActivityEndpoint {
  String displayActivity = "/user/display_all_activities";
  String searchActivity = "/user/search_activity/";
}

mixin OwnerEndpoint {
  String addActivity = "owner/add_activity";
  String addImage = "owner/add_image";
  String deleteActivity = "owner/delete_activity/";
  String displayOwnerActivities = "owner/display_owner_activities";
  String activityReservationsNumber = "owner/display_activity_reservations/";
}
