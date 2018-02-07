# OnTheMapProject

The On the Map app is a portfolio app that lets the user view URL links Udacity students have posted to Parse servers as well as post his or her own URL links.

## Installation

```
git clone https://github.com/acdelaney/OnTheMapProject.git
```

## Usage

On launch, the app opens to a login view where the user can login in using his or her Udacity username and password.  If the user doesn't have an account with Udacity, they can create one by selecting the Sign Up Here button.  A successful login in attempt navigates to the Map view controller.

On load, the most recent 100 posts including location, name, and the shared URL link are displayed on the map using pins.  Tapping a pin displays the call out with the user's name and the shared URL.  Selecting the call out, navigates to the URL.  The user can toggle between the map view and a table view displaying the downloaded data.  Selecting a row in the table navigates to the URL.  In the upper right, the user can reload the data by initiating a new download or navigate to the Add Location view.

The Add Location view asks the user to type where they are studying.  After typing a location and pressing Find on the Map, the map adds a pin to that location and zooms in.  Then the user can add a URL following the text prompts and select submit.  This will post this information to the Parse servers and navigate back to the map view.  Finally, selecting the Log Out button in the upper left will navigate back the Login view and end the session.  
