function populate() {
	//populate optionArray
	//make a form element
	var e = document.getElementById("tournament_id");
	var gameType = e.options[e.selectedIndex].text;
	if (gameType != "Select a Game Type") {
		alert(gameType + " was Selected!");
		//populate optionArray
		//select * from tournament_settings where gametype = GameType
		for(var option in optionArray){
			//identify the number of 
			;
		}
	};
}