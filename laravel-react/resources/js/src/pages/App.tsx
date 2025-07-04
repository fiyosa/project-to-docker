import { BrowserRouter, Routes, Route } from 'react-router'
import Base from './Base'
import Home from './guest/Home'
import About from './guest/About'
import NotFound from './guest/NotFound'

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route element={<Base />}>
          <Route index element={<Home />} />
          <Route path="/about" element={<About />} />

          <Route path="*" element={<NotFound />} />
        </Route>
      </Routes>
    </BrowserRouter>
  )
}
