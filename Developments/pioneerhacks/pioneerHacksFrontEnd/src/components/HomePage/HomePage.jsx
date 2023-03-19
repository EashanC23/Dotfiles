import React, { useContext, useRef, useState } from "react";
import "./HomePage.css"
import AppContext from "../../store/app-context";
import LoaderGraph from "../../loader";


const HomePage = props => {
	let inputRef = useRef("");
	const [isLoading, setIsLoading] = useState(false);
	const ctx = useContext(AppContext)

	const validateLink = () => {
		return true;
	}

	const formSubmitHandler = async (event) => {
		event.preventDefault()
		setIsLoading(true);
		const startIndex = inputRef.current.value.lastIndexOf("/biz/") + 5; // Adding 5 to remove "/biz/" from the string
		const endIndex = inputRef.current.value.lastIndexOf("?");

		const businessName = inputRef.current.value.slice(startIndex, endIndex).replaceAll("-", " ");

		console.log(businessName); // Output: Ippudo Cupertino
		ctx.setRestaurantName(businessName)
		if (validateLink()) {
			let id = inputRef.current.value
			console.log(id)
			let response = await fetch("https://yelp-guru.nicholaskann1.repl.co/get_info?url=" + id, {
				method: 'GET',
				headers: {
					'Accept': '*/*',
					'Connection': 'keep-alive',
					'Content-Type': 'application/json',
					'Access-Control-Allow-Origin': '*',
					'Access-Control-Allow-Headers': '*',
					'Access-Control-Allow-Credentials': true,
				}
			}).catch((err) => { alert(err) })
			let data = await response.json()
			data = JSON.parse(data.data)
			console.log(typeof data)
			console.log(data[0])
			console.log(data)//best foods
			let bestFoodsFetched = data[0]
			console.log(data[2])//popular foods
			let popularFoodsFetched = data[2]
			console.log(data[4])//calories
			let bestFoodsCaloriesFetched = data[4]
			console.log(data[5])//popular foods
			let popularFoodsCaloriesFetched = data[5]
			let bestFoods = []
			let popularFoods = []
			for (var i = 0; i < 3; i++) {
				bestFoods.push({ title: bestFoodsFetched[i], calories: bestFoodsCaloriesFetched[i] })
				popularFoods.push({ title: popularFoodsFetched[i], calories: popularFoodsCaloriesFetched[i] })

			}
			ctx.setBestFoods(bestFoods)
			console.log(bestFoods)
			ctx.setPopularFoods(popularFoods)
			console.log(popularFoods)
			setIsLoading(false);
			ctx.setIsHome(true)


		}
	}

	return (
		<form onSubmit={formSubmitHandler} className="HURR">
			{isLoading ? (
				<>
					<marquee> <h1> querying: {ctx.restaurantName}</h1> </marquee>
					<LoaderGraph />
				</>
			) : (
				<>
					<input ref={inputRef} placeholder="enter Yelp link for a restaurant" />

				</>)}
		</form>
	)
}

export default HomePage

