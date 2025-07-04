import './Home.css'
import { useNavigate } from 'react-router'
import { ImgReact, ImgVite } from '../../assets/img'

export default function NotFound() {
  const navigate = useNavigate()

  return (
    <>
      <div>
        <a href="https://vite.dev" target="_blank">
          <img src={ImgVite} className="logo" alt="Vite logo" />
        </a>
        <a href="https://react.dev" target="_blank">
          <img src={ImgReact} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>404 not found</h1>
      <div className="card">
        <button onClick={() => navigate('/')}>Home</button>
      </div>
      <p className="read-the-docs">Click on the Vite and React logos to learn more</p>
    </>
  )
}
