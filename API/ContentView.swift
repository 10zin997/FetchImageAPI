//
//  ContentView.swift
//  API
//
//  Created by Tenzin wangyal on 11/15/22.
//

import SwiftUI

struct ContentView: View {
    @State var apiData = [APIData]()
    var body: some View {
        NavigationView{
            List(apiData, id: \.thumbnailUrl){ url in
                let imgLink = url.thumbnailUrl
                AsyncImage(url: URL(string: imgLink)) { img in
                    img
                        .resizable()
                } placeholder: {
                    Text("LOADING...")
                }
            }
            .navigationTitle("Title")
            .task {
                fetchData()
            }
        }
    }
    func fetchData(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else{ print ("cant reach the server")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let decodedData = try? JSONDecoder().decode([APIData].self, from: data!){
                apiData = decodedData
            }
        }
        task.resume()
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

