public enum HTMLTag {
    case html
    case head
    case meta
    case base
    case link
    case script
    case style
    case title
    case body
    case address
    case article
    case aside
    case footer
    case header
    case h1
    case h2
    case h3
    case h4
    case h5
    case h6
    case hgroup
    case main
    case nav
    case section
    case search
    case blockquote
    case cite
    case dd
    case div
    case dl
    case dt
    case figcaption
    case figure
    case hr
    case li
    case ol
    case ul
    case menu
    case p
    case pre
    case a
    case abbr
    case b
    case bdi
    case bdo
    case br
    case code
    case data
    case dfn
    case em
    case i
    case kbd
    case mark
    case q
    case rp
    case ruby
    case rt
    case s
    case samp
    case small
    case span
    case strong
    case sub
    case sup
    case time
    case u
    case `var`
    case wbr
    case area
    case audio
    case img
    case map
    case track
    case video
    case embed
    case iframe
    case object
    case picture
    case source
    case portal
    case svg
    case canvas
    case noscript
    case del
    case ins
    case caption
    case col
    case colgroup
    case table
    case tbody
    case tr
    case td
    case tfoot
    case th
    case thead
    case button
    case datalist
    case option
    case fieldset
    case label
    case form
    case input
    case legend
    case meter
    case optgroup
    case select
    case output
    case progress
    case textarea
    case details
    case summary
    case dialog
    case slot
    case template

    @inlinable
    @inline(__always)
    public var isVoid: Bool {
        switch self {
        case .area, .base, .br, .col, .embed, .hr, .img, .input, .link, .meta, .source, .track,
             .wbr:
            return true
        default:
            return false
        }
    }

    @inlinable
    public func delimeters() -> (String, String) {
        isVoid ? ("<\(self)>", "") : ("<\(self)>", "</\(self)>")
    }
}
