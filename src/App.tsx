import { useState } from 'react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="App">
      <header className="App-header">
        <h1>Eskinder Kassahun</h1>
        <p>Cloud • DevOps • Security • AI Explorer</p>
        <p>Atlanta, GA</p>
        
        <div className="card">
          <button onClick={() => setCount((count) => count + 1)}>
            count is {count}
          </button>
          <p>
            Welcome to my portfolio! This is a React + TypeScript + Vite application.
          </p>
        </div>
        
        <p className="read-the-docs">
          This portfolio is deployed using GitHub Pages.
        </p>
      </header>
    </div>
  )
}

export default App