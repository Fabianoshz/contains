import React from 'react';
import { Slide } from 'react-slideshow-image';

const slideImages = [
  'images/slide_1.png',
  'images/slide_2.png'
];
 
const properties = {
  duration: 9999999,
  transitionDuration: 500,
  infinite: true,
  indicators: true,
  arrows: true,
  onChange: (oldIndex, newIndex) => {
    console.log(`slide transition from ${oldIndex} to ${newIndex}`);
  }
}
 
function App() {
  return (
    <div className="slide-container">
      <Slide {...properties}>
        {
          slideImages.map((each, index) => <img key={index} style={{width: "100%"}} src={each} />)
        }
      </Slide>
    </div>
  )
}

export default App;
