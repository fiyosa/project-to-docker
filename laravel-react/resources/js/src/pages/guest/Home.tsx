import { useState } from 'react'
import './Home.css'
import { useNavigate } from 'react-router'
import { ImgReact } from '../../assets/img'

export default function Home() {
  const [count, setCount] = useState(0)
  const navigate = useNavigate()

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          {/* <img src={ImgVite} className="logo" alt="Vite logo" /> */}
          <img src="/vite.svg" className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={ImgReact} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>count is {count}</button>
        <div style={{ marginTop: '1rem' }}>
          <button onClick={() => navigate('/about')}>About Page</button>
        </div>
        <p>
          Edit <code>src/App.tsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">Click on the Vite and React logos to learn more</p>
    </>
  )
}
