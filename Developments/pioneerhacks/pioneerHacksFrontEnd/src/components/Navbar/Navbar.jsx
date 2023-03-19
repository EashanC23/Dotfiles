import React from "react";
import "./NavBar.css"

const NavBar = props => {
	return (
		<header className="header">
			<h1 onClick={()=>location.reload()}> Yelp Wizard </h1>
		</header>
	)
}
export default NavBar
