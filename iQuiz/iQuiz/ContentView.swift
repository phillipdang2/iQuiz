//
//  ContentView.swift
//  iQuiz
//
//  Created by Phillip Dang on 5/20/24.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        @StateObject var viewModel = ViewModel()
        let quizzes = [
            testQuiz(title: "Mathematics", desc: "Math"),
            testQuiz(title: "Marvel Superheroes", desc: "Batman"),
            testQuiz(title: "Science", desc: "wow")]
        NavigationView {
            List(quizzes) { item in
                VStack(alignment: .leading) {
                    Text(item.title)
                    Text(item.desc)
                }
            }
            .navigationBarTitle(Text("iQuiz"))
            .onAppear {
                viewModel.fetch()
            }
        }
    }
}

class ViewModel: ObservableObject {
    @Published var quizzes: [Quiz] = []

    func fetch() {
        guard let url = URL(string: "http://tednewardsandbox.site44.com/questions.json") else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: (error)")
                return
            }

            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let decodedQuizzes = try JSONDecoder().decode([Quiz].self, from: data)
                DispatchQueue.main.async {
                    self.quizzes = decodedQuizzes
                }
            } catch {
                print("Error decoding data: (error)")
            }
        }

        task.resume()
    }
}

#Preview {
    ContentView()
}
