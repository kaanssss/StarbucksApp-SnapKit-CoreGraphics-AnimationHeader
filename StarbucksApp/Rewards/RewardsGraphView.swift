//
//  RewardsGraphView.swift
//  StarbucksApp
//
//  Created by Kaan Yalçınkaya on 5.10.2022.
//

import UIKit

class RewardsGraphView: UIView {
    
    let imageView = UIImageView()
    
    let initialFrameWidth: CGFloat = 200 // Rastgele verilen yükseklik.
    var actualFrameWidth: CGFloat?
    
    let height: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        drawRewardsGraph()
        
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func drawRewardsGraph() {
        
        let frameWidth: CGFloat = actualFrameWidth ?? initialFrameWidth
        
        let padding: CGFloat = 20
        let dotSize: CGFloat = 12
        let lineWidth: CGFloat = 2
        let numberOfDots: CGFloat = 5
        let numberOfSections = numberOfDots - 1
        
        let spacingBetweenDots = (frameWidth - 2 * padding) / (numberOfSections + 0.5)
        
        let shortSegmentLenght = spacingBetweenDots * 0.25
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: frameWidth, height: height))
        
        var dots: [CGPoint] = []
        let labels: [String] = ["25", "50", "150", "250", "400"]
        
        //Çekirdek grafikler çizilirken çerçevesi ikiye bölünür fakat biz bir daire istiyoruz.
        //Tam olarak bu noktada, y'yi "50" ile dengelememiz gerekiyor.
        //Yeşil göstergeye yer açmak için her şeyi aşağı itiyoruz.
        let indicatorOffSet: CGFloat = 34
        let yOffSet = (dotSize + lineWidth) / 2 + indicatorOffSet
        
        let img = renderer.image { ctx in
            //Noktaları tanımlama.
            for index in 0...Int((numberOfDots - 1)) {
                let x = padding + shortSegmentLenght + (spacingBetweenDots * CGFloat(index))
                dots.append(CGPoint(x: x, y: yOffSet))
            }
            
            //Noktalar arasındaki çizgileri tanımlama.
            ctx.cgContext.setLineWidth(lineWidth)
            ctx.cgContext.setStrokeColor(UIColor.systemGray4.cgColor)
            
            //Başlangıç segmenti.
            let firstShortSegmentBegin = padding
            let firstShortSegmentEnd = padding + shortSegmentLenght - dotSize / 2
            
            ctx.cgContext.move(to: CGPoint(x: firstShortSegmentBegin, y: yOffSet))
            ctx.cgContext.addLine(to: CGPoint(x: firstShortSegmentEnd, y: yOffSet))
            ctx.cgContext.strokePath()
            
            //Bitiş segmenti çizmek için.
            let lastShortSegmentEnd = frameWidth - padding
            let lastShortSegmentBegin = lastShortSegmentEnd - shortSegmentLenght
            
            ctx.cgContext.move(to: CGPoint(x: lastShortSegmentBegin, y: yOffSet))
            ctx.cgContext.addLine(to: CGPoint(x: lastShortSegmentEnd, y: yOffSet))
            ctx.cgContext.strokePath()
            
            ctx.cgContext.addLines(between: dots)
            ctx.cgContext.strokePath()
            
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            
            //Noktaları çizmek için.
            for dot in dots {
                let dotBounds = CGRect(x: dot.x - (dotSize * 0.5),
                                       y: dot.y - (dotSize * 0.5),
                                       width: dotSize, height: dotSize)
                ctx.cgContext.addEllipse(in: dotBounds)
                ctx.cgContext.drawPath(using: CGPathDrawingMode.fillStroke)
            }
            
            //Beraberlik noktası tüketmek için.
            let pointsConsumedBegin = firstShortSegmentBegin
            let pointsConsumedEnd = padding + shortSegmentLenght / 2
            
            ctx.cgContext.setStrokeColor(UIColor.starYellow.cgColor)
            
            ctx.cgContext.move(to: CGPoint(x: pointsConsumedBegin, y: yOffSet))
            ctx.cgContext.addLine(to: CGPoint(x: pointsConsumedEnd, y: yOffSet))
            ctx.cgContext.strokePath()
            
            //Yeşil gösterge için.
            let indicatorX = pointsConsumedEnd - 8
            let indicatorY = yOffSet - 36
            let star = UIImage(named: "green-indicator")
            
            star?.draw(at: CGPoint(x: indicatorX, y: indicatorY))
            
            //Labelları çizmek için.
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.preferredFont(forTextStyle: .footnote),
                .paragraphStyle: paragraphStyle
            ]
            
            for (i, dot) in dots.enumerated() {
                
                let string = labels[i]
                
                let attributedString = NSAttributedString(string: string, attributes: attrs)
                attributedString.draw(with: CGRect(x: dot.x - 15, y: dot.y + 16, width: 30, height: 20), options: .usesLineFragmentOrigin, context: nil)
            }
        }
        
        imageView.image = img
    }
}
