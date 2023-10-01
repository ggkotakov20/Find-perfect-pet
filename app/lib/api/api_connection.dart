class API{
  static const hostConnection = "https://api.kremito.com";
  static const hostConnectionUser = "$hostConnection/user";

  static const validateEmail = "$hostConnection/user/validate_email.php";
  static const signUp = "$hostConnection/user/signup.php";
  static const signIn = "$hostConnection/user/signin.php";
  
  static const mapPoint = "$hostConnection/map-point.php";
  
  static const addAdvert = "$hostConnection/advert/add_advert.php";
  static const yourAdvert = "$hostConnection/advert/your_advert.php";
  static const editAdvert = "$hostConnection/advert/edit_advert.php";
  static const deleteAdvert = "$hostConnection/advert/delete_advert.php";
  
  static const viewAdvert = "$hostConnection/advert.php";

  static const search = "$hostConnection/search.php";
  static const addFavorite = "$hostConnection/favorite/favorite.php";

  
  static const userPet = "$hostConnection/user_pet/pet_profile.php";
  static const editUserPet = "$hostConnection/user_pet/edit_pet_profile.php";
  static const addUserPet = "$hostConnection/user_pet/add_pet_profile.php";
}