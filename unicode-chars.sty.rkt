#lang at-exp racket
(provide unicode-chars)
(define unicode-chars
  @string-append|<<<{
\input glyphtounicode
\pdfgentounicode=1
\usepackage{accsupp}
%$\BeginAccSupp{method=hex,unicode,ActualText=2200}∀\EndAccSupp{}
% \BeginAccSupp{method=hex,unicode,ActualText=2192}→\EndAccSupp{}$
\usepackage{bbold}
\usepackage{savesym}
\savesymbol{iint}
\savesymbol{iiint}
\savesymbol{dddot}
\savesymbol{ddddot}
\savesymbol{overleftrightarrow}
\savesymbol{underrightarrow}
\savesymbol{underleftarrow}
\savesymbol{underleftrightarrow}
\usepackage{amsmath}
\restoresymbol{ams}{iint}
\restoresymbol{ams}{iiint}
\restoresymbol{ams}{dddot}
\restoresymbol{ams}{ddddot}
\restoresymbol{ams}{underrightarrow}
\restoresymbol{ams}{underleftarrow}
\restoresymbol{ams}{underleftrightarrow}
\savesymbol{ulcorner}
\savesymbol{urcorner}
\savesymbol{llcorner}
\savesymbol{lrcorner}
\usepackage{amsfonts}
\restoresymbol{ams}{ulcorner}
\restoresymbol{ams}{urcorner}
\restoresymbol{ams}{llcorner}
\restoresymbol{ams}{lrcorner}
\usepackage{mathtools}
\makeatletter
% Must be loaded after MnSymbol!!! MnSymbol improperly defines × and ¬ in such a
%   way that they don't work in math mode.
% definition of some characters, for use with
% \usepackage[utf8]{inputenc}
% \usepackage[T1]{fontenc}
% Author: Christoph Lange <math.semantic.web@gmail.com>
% Some math characters taken from John Wickerson's MathUnicode.sty
%  (http://tex.stackexchange.com/questions/110042/
%     entering-unicode-math-symbols-into-latex-direct-from-keyboard-on-a-mac)
% https://github.com/clange/latex
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
%\ProvidesPackage{unicode-chars}[2013/10/08]

\DeclareUnicodeCharacter{00A0}{~}%                                 " " (nbsp)
\DeclareUnicodeCharacter{00A3}{\pounds}%                           £
\DeclareUnicodeCharacter{00AB}{%
 \ifmmode\textrm{\guillemotleft}\else\guillemotleft\fi}%«
% Declared by MnSymbol:
\DeclareUnicodeCharacter{00AC}{\ensuremath{\neg}}%                 ¬
\DeclareUnicodeCharacter{00AE}{\textsuperscript{\textregistered}}% ®
\DeclareUnicodeCharacter{00AF}{\ensuremath{^-}}%                   ¯
\DeclareUnicodeCharacter{00BB}{%
 \ifmmode\textrm{\guillemotright}\else\guillemotright\fi}%»
% Declared by MnSymbol:
\DeclareUnicodeCharacter{00D7}{\ensuremath{\times}}%               ×
\DeclareUnicodeCharacter{00F1}{{\ifmmode\tilde{n}\else\~{n}\fi}}%  ñ

\DeclareUnicodeCharacter{0101}{\=a}%                               ā
\DeclareUnicodeCharacter{0123}{\c g}%                              ģ
\DeclareUnicodeCharacter{0130}{\. I}%                              İ
\DeclareUnicodeCharacter{0146}{\c n}%                              ņ
\DeclareUnicodeCharacter{016B}{\=u}%                               ū
\DeclareUnicodeCharacter{03B1}{\ensuremath{\alpha}}%               α
\DeclareUnicodeCharacter{03B4}{\ensuremath{\delta}}%               δ
\DeclareUnicodeCharacter{0394}{\ensuremath{\Delta}}%               Δ
\DeclareUnicodeCharacter{03F5}{\ensuremath{\epsilon}}%             ϵ
\DeclareUnicodeCharacter{03B5}{\ensuremath{\varepsilon}}%          ε
\DeclareUnicodeCharacter{0395}{\ensuremath{\Epsilon}}%             Ε
\DeclareUnicodeCharacter{03BB}{\ensuremath{\lambda}}%              λ
\DeclareUnicodeCharacter{039B}{\ensuremath{\Lambda}}%              Λ
\DeclareUnicodeCharacter{03C1}{\ensuremath{\rho}}%                 ρ
\DeclareUnicodeCharacter{03A1}{\ensuremath{\Rho}}%                 Ρ
\DeclareUnicodeCharacter{2190}{\ensuremath{\leftarrow}}%           ←
\DeclareUnicodeCharacter{2192}{\ensuremath{\BeginAccSupp{method=hex,unicode,ActualText=2192}\rightarrow\EndAccSupp{}}}%          →
% 2192: \textrightarrow is not available in all fonts,
% and we need the right arrow in math mode
\DeclareUnicodeCharacter{2193}{\ensuremath{\downarrow}}%           ↓
\DeclareUnicodeCharacter{2194}{\ensuremath{\leftrightarrow}}%      ↔
\DeclareUnicodeCharacter{21A6}{\ensuremath{\mapsto}}%              ↦
\DeclareUnicodeCharacter{21C0}{\ensuremath{\rightharpoonup}}%      ⇀
\DeclareUnicodeCharacter{21D2}{\ensuremath{\Rightarrow}}%          ⇒
% Georges — added \operatorname{} in ∀ .
\DeclareUnicodeCharacter{2200}{\ensuremath{\operatorname{\BeginAccSupp{method=hex,unicode,ActualText=2200}\forall\EndAccSupp{}}}}% ∀
\DeclareUnicodeCharacter{2203}{\ensuremath{\exists}}%              ∃
\DeclareUnicodeCharacter{2208}{\ensuremath{\in}}%                  ∈
\DeclareUnicodeCharacter{2209}{\ensuremath{\not\in}}%              ∉
\DeclareUnicodeCharacter{2211}{\ensuremath{\sum}}%                 ∑
\DeclareUnicodeCharacter{220F}{\ensuremath{\prod}}%                ∏
\DeclareUnicodeCharacter{2218}{\ensuremath{\circ}}%                ∘
\DeclareUnicodeCharacter{2227}{\ensuremath{\mathbin{\wedge}}}%               ∧
\DeclareUnicodeCharacter{2228}{\ensuremath{\mathbin{\vee}}}%                 ∨
\DeclareUnicodeCharacter{2229}{\ensuremath{\mathbin{\cap}}}%                 ∩
\DeclareUnicodeCharacter{222A}{\ensuremath{\mathbin{\cup}}}%                 ∪
\DeclareUnicodeCharacter{228D}{\ensuremath{\mathbin{\cupdot}}}%              ⊍
\DeclareUnicodeCharacter{228E}{\ensuremath{\mathbin{\uplus}}}%               ⊎
%\DeclareUnicodeCharacter{2237}{\ensuremath{::}}%                   ∷
% 2237: not sure that's a good way to render this symbol
\DeclareUnicodeCharacter{2248}{\ensuremath{\approx}}%              ≈
\DeclareUnicodeCharacter{2260}{\ensuremath{\ne}}%                  ≠
\DeclareUnicodeCharacter{2261}{\ensuremath{\equiv}}%               ≡
\DeclareUnicodeCharacter{2262}{\ensuremath{\not\equiv}}%           ≢
\DeclareUnicodeCharacter{2264}{\ensuremath{\le}}%                  ≤
\DeclareUnicodeCharacter{2265}{\ensuremath{\ge}}%                  ≥
\DeclareUnicodeCharacter{2286}{\ensuremath{\subseteq}}%            ⊆
\DeclareUnicodeCharacter{2282}{\ensuremath{\subset}}%              ⊂
\DeclareUnicodeCharacter{2287}{\ensuremath{\supseteq}}%            ⊇
\DeclareUnicodeCharacter{2283}{\ensuremath{\supset}}%              ⊃
\DeclareUnicodeCharacter{219D}{\ensuremath{\leadsto}}%             ↝
\@ifpackageloaded{MnSymbol}{%
\DeclareUnicodeCharacter{2295}{\ensuremath{\oplus}}%               ⊕
\DeclareUnicodeCharacter{2296}{\ensuremath{\ominus}}%              ⊖
}{}
\DeclareUnicodeCharacter{22C0}{\ensuremath{\bigwedge}}%            ⋀ 
\DeclareUnicodeCharacter{22C0}{\ensuremath{\bigcupdot}}%           ⋀ % TODO?!
\DeclareUnicodeCharacter{22C1}{\ensuremath{\biguplus}}%            ⋁ % TODO?!
\DeclareUnicodeCharacter{22C2}{\ensuremath{\bigcap}}%              ⋂
\DeclareUnicodeCharacter{22C3}{\ensuremath{\bigcup}}%              ⋃
\DeclareUnicodeCharacter{2A03}{\ensuremath{\bigcupdot}}%           ⨃
\DeclareUnicodeCharacter{2A04}{\ensuremath{\biguplus}}%            ⨄
\DeclareUnicodeCharacter{25CB}{\ensuremath{\ocircle}}%             ○
\@ifpackageloaded{MnSymbol}{%
\DeclareUnicodeCharacter{2605}{\ensuremath{\filledlargestar}}%     ★
}{}
\DeclareUnicodeCharacter{2713}{\ensuremath{\checkmark}}%           ✓
\DeclareUnicodeCharacter{27F6}{\ensuremath{\longrightarrow}}%      ⟶
\DeclareUnicodeCharacter{27F7}{\ensuremath{\longleftrightarrow}}%  ⟷
\DeclareUnicodeCharacter{27F9}{\ensuremath{\Longrightarrow}}%      ⟹
%
% Additions by Georges Dupéron
\DeclareUnicodeCharacter{2237}{\ensuremath{\dblcolon}}%            ∷
\DeclareUnicodeCharacter{228F}{\ensuremath{\sqsubset}}%            ⊏
\DeclareUnicodeCharacter{2290}{\ensuremath{\sqsubset}}%            ⊐
\DeclareUnicodeCharacter{2291}{\ensuremath{\sqsubseteq}}%          ⊑
\DeclareUnicodeCharacter{2292}{\ensuremath{\sqsupseteq}}%          ⊒
\DeclareUnicodeCharacter{2293}{\ensuremath{\sqcap}}%               ⊓
\DeclareUnicodeCharacter{2294}{\ensuremath{\sqcup}}%               ⊔
%
\usepackage{graphicx}%
\providecommand{\bigsqcap}{%
  \mathop{%
    \mathpalette\@updown\bigsqcup
  }%
}
\newcommand*{\@updown}[2]{%
  \rotatebox[origin=c]{180}{$\m@th#1#2$}%
}
\DeclareUnicodeCharacter{2A05}{\ensuremath{\bigsqcap}}%            ⨅
\DeclareUnicodeCharacter{2A06}{\ensuremath{\bigsqcup}}%            ⨆
\DeclareUnicodeCharacter{2080}{\ensuremath{{}_0}}%                   ₀
\DeclareUnicodeCharacter{2081}{\ensuremath{\BeginAccSupp{method=hex,unicode,ActualText=2081}{}_1\EndAccSupp{}}}%                   ₁
\DeclareUnicodeCharacter{2082}{\ensuremath{{}_2}}%                   ₂
\DeclareUnicodeCharacter{2083}{\ensuremath{{}_3}}%                   ₃
\DeclareUnicodeCharacter{2084}{\ensuremath{{}_4}}%                   ₄
\DeclareUnicodeCharacter{2085}{\ensuremath{{}_5}}%                   ₅
\DeclareUnicodeCharacter{2086}{\ensuremath{{}_6}}%                   ₆
\DeclareUnicodeCharacter{2087}{\ensuremath{{}_7}}%                   ₇
\DeclareUnicodeCharacter{2088}{\ensuremath{{}_8}}%                   ₈
\DeclareUnicodeCharacter{2089}{\ensuremath{{}_9}}%                   ₉
\DeclareUnicodeCharacter{208A}{\ensuremath{{}_+}}%                   ₊
\DeclareUnicodeCharacter{208B}{\ensuremath{{}_-}}%                   ₋
\DeclareUnicodeCharacter{208C}{\ensuremath{{}_=}}%                   ₌
\DeclareUnicodeCharacter{208D}{\ensuremath{{}_(}}%                   ₍
\DeclareUnicodeCharacter{208E}{\ensuremath{{}_)}}%                   ₎
\DeclareUnicodeCharacter{2098}{\ensuremath{{}_m}}%                   ₘ
\DeclareUnicodeCharacter{2099}{\ensuremath{{}_n}}%                   ₙ
\DeclareUnicodeCharacter{2095}{\ensuremath{{}_h}}%                   ₕ
\DeclareUnicodeCharacter{1D62}{\ensuremath{{}_i}}%                   ᵢ
\DeclareUnicodeCharacter{2C7C}{\ensuremath{{}_j}}%                   ⱼ
\DeclareUnicodeCharacter{2096}{\ensuremath{{}_k}}%                   ₖ
\DeclareUnicodeCharacter{2097}{\ensuremath{{}_l}}%                   ₗ
\DeclareUnicodeCharacter{209B}{\ensuremath{{}_s}}%                   ₛ
%
\DeclareUnicodeCharacter{2070}{\ensuremath{{}^0}}%                   ⁰
%\DeclareUnicodeCharacter{00B9}{\ensuremath{{}^1}}%                   ¹
%\DeclareUnicodeCharacter{00B2}{\ensuremath{{}^2}}%                   ²
%\DeclareUnicodeCharacter{00B3}{\ensuremath{{}^3}}%                   ³
\DeclareUnicodeCharacter{2074}{\ensuremath{{}^4}}%                   ⁴
\DeclareUnicodeCharacter{2075}{\ensuremath{{}^5}}%                   ⁵
\DeclareUnicodeCharacter{2076}{\ensuremath{{}^6}}%                   ⁶
\DeclareUnicodeCharacter{2077}{\ensuremath{{}^7}}%                   ⁷
\DeclareUnicodeCharacter{2078}{\ensuremath{{}^8}}%                   ⁸
\DeclareUnicodeCharacter{2079}{\ensuremath{{}^9}}%                   ⁹
\DeclareUnicodeCharacter{207A}{\ensuremath{{}^+}}%                   ⁺
\DeclareUnicodeCharacter{207B}{\ensuremath{{}^-}}%                   ⁻
\DeclareUnicodeCharacter{207C}{\ensuremath{{}^=}}%                   ⁼
\DeclareUnicodeCharacter{207D}{\ensuremath{{}^(}}%                   ⁽
\DeclareUnicodeCharacter{207E}{\ensuremath{{}^)}}%                   ⁾
\DeclareUnicodeCharacter{207F}{\ensuremath{{}^n}}%                   ⁿ
\DeclareUnicodeCharacter{2071}{\ensuremath{{}^i}}%                   ⁱ
\DeclareUnicodeCharacter{02B2}{\ensuremath{{}^j}}%                   ʲ
\DeclareUnicodeCharacter{1D4F}{\ensuremath{{}^k}}%                   ᵏ
%s
\DeclareUnicodeCharacter{2026}{\ensuremath{\dots}}%                …

% Generated from ~/.XCompose using:
% cat /tmp/cal.txt | cut -d '"' -f 2- | tr '"' ' ' | cut -d ' ' -f 1,6 \
% | while IFS=' ' read a b; do
%   echo -n "\\DeclareUnicodeCharacter{$(printf "%X" "'$a")}"
%   echo "{\\\\ensuremath{\\mathcal{$b}}}%         $a";
% done

\DeclareUnicodeCharacter{1D49C}{\ensuremath{\mathcal{A}}}%         𝒜
\DeclareUnicodeCharacter{212C}{\ensuremath{\mathcal{B}}}%          ℬ
\DeclareUnicodeCharacter{1D49E}{\ensuremath{\mathcal{C}}}%         𝒞
\DeclareUnicodeCharacter{1D49F}{\ensuremath{\mathcal{D}}}%         𝒟
\DeclareUnicodeCharacter{2130}{\ensuremath{\mathcal{E}}}%          ℰ
\DeclareUnicodeCharacter{2131}{\ensuremath{\mathcal{F}}}%          ℱ
\DeclareUnicodeCharacter{1D4A2}{\ensuremath{\mathcal{G}}}%         𝒢
\DeclareUnicodeCharacter{210B}{\ensuremath{\mathcal{H}}}%          ℋ
\DeclareUnicodeCharacter{2110}{\ensuremath{\mathcal{I}}}%          ℐ
\DeclareUnicodeCharacter{1D4A5}{\ensuremath{\mathcal{J}}}%         𝒥
\DeclareUnicodeCharacter{1D4A6}{\ensuremath{\mathcal{K}}}%         𝒦
\DeclareUnicodeCharacter{2112}{\ensuremath{\mathcal{L}}}%          ℒ
\DeclareUnicodeCharacter{2133}{\ensuremath{\mathcal{M}}}%          ℳ
\DeclareUnicodeCharacter{1D4A9}{\ensuremath{\mathcal{N}}}%         𝒩
\DeclareUnicodeCharacter{1D4AA}{\ensuremath{\mathcal{O}}}%         𝒪
\DeclareUnicodeCharacter{1D4AB}{\ensuremath{\mathcal{P}}}%         𝒫
\DeclareUnicodeCharacter{1D4AC}{\ensuremath{\mathcal{Q}}}%         𝒬
\DeclareUnicodeCharacter{211B}{\ensuremath{\mathcal{R}}}%          ℛ
\DeclareUnicodeCharacter{1D4AE}{\ensuremath{\mathcal{S}}}%         𝒮
\DeclareUnicodeCharacter{1D4AF}{\ensuremath{\mathcal{T}}}%         𝒯
\DeclareUnicodeCharacter{1D4B0}{\ensuremath{\mathcal{U}}}%         𝒰
\DeclareUnicodeCharacter{1D4B1}{\ensuremath{\mathcal{V}}}%         𝒱
\DeclareUnicodeCharacter{1D4B2}{\ensuremath{\mathcal{W}}}%         𝒲
\DeclareUnicodeCharacter{1D4B3}{\ensuremath{\mathcal{X}}}%         𝒳
\DeclareUnicodeCharacter{1D4B4}{\ensuremath{\mathcal{Y}}}%         𝒴
\DeclareUnicodeCharacter{1D4B5}{\ensuremath{\mathcal{Z}}}%         𝒵
\DeclareUnicodeCharacter{1D4B6}{\ensuremath{\mathcal{a}}}%         𝒶
\DeclareUnicodeCharacter{1D4B7}{\ensuremath{\mathcal{b}}}%         𝒷
\DeclareUnicodeCharacter{1D4B8}{\ensuremath{\mathcal{c}}}%         𝒸
\DeclareUnicodeCharacter{1D4B9}{\ensuremath{\mathcal{d}}}%         𝒹
\DeclareUnicodeCharacter{212F}{\ensuremath{\mathcal{e}}}%          ℯ
\DeclareUnicodeCharacter{1D4BB}{\ensuremath{\mathcal{f}}}%         𝒻
\DeclareUnicodeCharacter{210A}{\ensuremath{\mathcal{g}}}%          ℊ
\DeclareUnicodeCharacter{1D4BD}{\ensuremath{\mathcal{h}}}%         𝒽
\DeclareUnicodeCharacter{1D4BE}{\ensuremath{\mathcal{i}}}%         𝒾
\DeclareUnicodeCharacter{1D4BF}{\ensuremath{\mathcal{j}}}%         𝒿
\DeclareUnicodeCharacter{1D4C0}{\ensuremath{\mathcal{k}}}%         𝓀
\DeclareUnicodeCharacter{1D4C1}{\ensuremath{\mathcal{l}}}%         𝓁
\DeclareUnicodeCharacter{1D4C2}{\ensuremath{\mathcal{m}}}%         𝓂
\DeclareUnicodeCharacter{1D4C3}{\ensuremath{\mathcal{n}}}%         𝓃
\DeclareUnicodeCharacter{2134}{\ensuremath{\mathcal{o}}}%          ℴ
\DeclareUnicodeCharacter{1D4C5}{\ensuremath{\mathcal{p}}}%         𝓅
\DeclareUnicodeCharacter{1D4C6}{\ensuremath{\mathcal{q}}}%         𝓆
\DeclareUnicodeCharacter{1D4C7}{\ensuremath{\mathcal{r}}}%         𝓇
\DeclareUnicodeCharacter{1D4C8}{\ensuremath{\mathcal{s}}}%         𝓈
\DeclareUnicodeCharacter{1D4C9}{\ensuremath{\mathcal{t}}}%         𝓉
\DeclareUnicodeCharacter{1D4CA}{\ensuremath{\mathcal{u}}}%         𝓊
\DeclareUnicodeCharacter{1D4CB}{\ensuremath{\mathcal{v}}}%         𝓋
\DeclareUnicodeCharacter{1D4CC}{\ensuremath{\mathcal{w}}}%         𝓌
\DeclareUnicodeCharacter{1D4CD}{\ensuremath{\mathcal{x}}}%         𝓍
\DeclareUnicodeCharacter{1D4CE}{\ensuremath{\mathcal{y}}}%         𝓎
\DeclareUnicodeCharacter{1D4CF}{\ensuremath{\mathcal{z}}}%         𝓏
\DeclareUnicodeCharacter{220C}{\ensuremath{\not\ni}}%              ∌
\DeclareUnicodeCharacter{220B}{\ensuremath{\ni}}%                  ∋
\DeclareUnicodeCharacter{2008}{\,}%                            Punctuation space
\DeclareUnicodeCharacter{2032}{\ensuremath{'}}%                    ′ (Prime)
\DeclareUnicodeCharacter{2033}{\ensuremath{''}}%                   ″ (2x Prime)
\DeclareUnicodeCharacter{2034}{\ensuremath{'''}}%                  ‴ (3x Prime)
\DeclareUnicodeCharacter{2057}{\ensuremath{''''}}%                 ⁗ (4x Prime)
\DeclareUnicodeCharacter{1D538}{\ensuremath{\mathbb{A}}}%          𝔸
\DeclareUnicodeCharacter{1D539}{\ensuremath{\mathbb{B}}}%          𝔹
\DeclareUnicodeCharacter{2102}{\ensuremath{\mathbb{C}}}%           ℂ
\DeclareUnicodeCharacter{1D53B}{\ensuremath{\mathbb{D}}}%          𝔻
\DeclareUnicodeCharacter{1D53C}{\ensuremath{\mathbb{E}}}%          𝔼
\DeclareUnicodeCharacter{1D53D}{\ensuremath{\mathbb{F}}}%          𝔽
\DeclareUnicodeCharacter{1D53E}{\ensuremath{\mathbb{G}}}%          𝔾
\DeclareUnicodeCharacter{210D}{\ensuremath{\mathbb{H}}}%           ℍ
\DeclareUnicodeCharacter{1D540}{\ensuremath{\mathbb{I}}}%          𝕀
\DeclareUnicodeCharacter{1D541}{\ensuremath{\mathbb{J}}}%          𝕁
\DeclareUnicodeCharacter{1D542}{\ensuremath{\mathbb{K}}}%          𝕂
\DeclareUnicodeCharacter{1D543}{\ensuremath{\mathbb{L}}}%          𝕃
\DeclareUnicodeCharacter{1D544}{\ensuremath{\mathbb{M}}}%          𝕄
\DeclareUnicodeCharacter{2115}{\ensuremath{\mathbb{N}}}%           ℕ
\DeclareUnicodeCharacter{1D546}{\ensuremath{\mathbb{O}}}%          𝕆
\DeclareUnicodeCharacter{2119}{\ensuremath{\mathbb{P}}}%           ℙ
\DeclareUnicodeCharacter{211A}{\ensuremath{\mathbb{Q}}}%           ℚ
\DeclareUnicodeCharacter{211D}{\ensuremath{\mathbb{R}}}%           ℝ
\DeclareUnicodeCharacter{1D54A}{\ensuremath{\mathbb{S}}}%          𝕊
\DeclareUnicodeCharacter{1D54B}{\ensuremath{\mathbb{T}}}%          𝕋
\DeclareUnicodeCharacter{1D54C}{\ensuremath{\mathbb{U}}}%          𝕌
\DeclareUnicodeCharacter{1D54D}{\ensuremath{\mathbb{V}}}%          𝕍
\DeclareUnicodeCharacter{1D54E}{\ensuremath{\mathbb{W}}}%          𝕎
\DeclareUnicodeCharacter{1D54F}{\ensuremath{\mathbb{X}}}%          𝕏
\DeclareUnicodeCharacter{1D550}{\ensuremath{\mathbb{Y}}}%          𝕐
\DeclareUnicodeCharacter{2124}{\ensuremath{\mathbb{Z}}}%           ℤ
\DeclareUnicodeCharacter{213C}{\ensuremath{\mathbb{\pi}}}%         ℼ
\DeclareUnicodeCharacter{213D}{\ensuremath{\mathbb{\gamma}}}%      ℽ
\DeclareUnicodeCharacter{213E}{\ensuremath{\mathbb{\Gamma}}}%      ℾ
\DeclareUnicodeCharacter{213F}{\ensuremath{\mathbb{\Pi}}}%         ℿ
\DeclareUnicodeCharacter{2140}{\ensuremath{\mathbb{\Sigma}}}%      ⅀
\DeclareUnicodeCharacter{1D7D8}{\ensuremath{\mathbb{0}}}%          𝟘
\DeclareUnicodeCharacter{1D7D9}{\ensuremath{\mathbb{1}}}%          𝟙
\DeclareUnicodeCharacter{1D7DA}{\ensuremath{\mathbb{2}}}%          𝟚
\DeclareUnicodeCharacter{1D7DB}{\ensuremath{\mathbb{3}}}%          𝟛
\DeclareUnicodeCharacter{1D7DC}{\ensuremath{\mathbb{4}}}%          𝟜
\DeclareUnicodeCharacter{1D7DD}{\ensuremath{\mathbb{5}}}%          𝟝
\DeclareUnicodeCharacter{1D7DE}{\ensuremath{\mathbb{6}}}%          𝟞
\DeclareUnicodeCharacter{1D7DF}{\ensuremath{\mathbb{7}}}%          𝟟
\DeclareUnicodeCharacter{1D7E0}{\ensuremath{\mathbb{8}}}%          𝟠
\DeclareUnicodeCharacter{1D7E1}{\ensuremath{\mathbb{9}}}%          𝟡
\DeclareUnicodeCharacter{1D552}{\ensuremath{\mathbb{a}}}%          𝕒
\DeclareUnicodeCharacter{1D553}{\ensuremath{\mathbb{b}}}%          𝕓
\DeclareUnicodeCharacter{1D554}{\ensuremath{\mathbb{c}}}%          𝕔
\DeclareUnicodeCharacter{1D555}{\ensuremath{\mathbb{d}}}%          𝕕
\DeclareUnicodeCharacter{1D556}{\ensuremath{\mathbb{e}}}%          𝕖
\DeclareUnicodeCharacter{1D557}{\ensuremath{\mathbb{f}}}%          𝕗
\DeclareUnicodeCharacter{1D558}{\ensuremath{\mathbb{g}}}%          𝕘
\DeclareUnicodeCharacter{1D559}{\ensuremath{\mathbb{h}}}%          𝕙
\DeclareUnicodeCharacter{1D55A}{\ensuremath{\mathbb{i}}}%          𝕚
\DeclareUnicodeCharacter{1D55B}{\ensuremath{\mathbb{j}}}%          𝕛
\DeclareUnicodeCharacter{1D55C}{\ensuremath{\mathbb{k}}}%          𝕜
\DeclareUnicodeCharacter{1D55D}{\ensuremath{\mathbb{l}}}%          𝕝
\DeclareUnicodeCharacter{1D55E}{\ensuremath{\mathbb{m}}}%          𝕞
\DeclareUnicodeCharacter{1D55F}{\ensuremath{\mathbb{n}}}%          𝕟
\DeclareUnicodeCharacter{1D560}{\ensuremath{\mathbb{o}}}%          𝕠
\DeclareUnicodeCharacter{1D561}{\ensuremath{\mathbb{p}}}%          𝕡
\DeclareUnicodeCharacter{1D562}{\ensuremath{\mathbb{q}}}%          𝕢
\DeclareUnicodeCharacter{1D563}{\ensuremath{\mathbb{r}}}%          𝕣
\DeclareUnicodeCharacter{1D564}{\ensuremath{\mathbb{s}}}%          𝕤
\DeclareUnicodeCharacter{1D565}{\ensuremath{\mathbb{t}}}%          𝕥
\DeclareUnicodeCharacter{1D566}{\ensuremath{\mathbb{u}}}%          𝕦
\DeclareUnicodeCharacter{1D567}{\ensuremath{\mathbb{v}}}%          𝕧
\DeclareUnicodeCharacter{1D568}{\ensuremath{\mathbb{w}}}%          𝕨
\DeclareUnicodeCharacter{1D569}{\ensuremath{\mathbb{x}}}%          𝕩
\DeclareUnicodeCharacter{1D56A}{\ensuremath{\mathbb{y}}}%          𝕪
\DeclareUnicodeCharacter{1D56B}{\ensuremath{\mathbb{z}}}%          𝕫
\DeclareUnicodeCharacter{03C4}{\ensuremath{\tau}}%                 τ
\DeclareUnicodeCharacter{221E}{\ensuremath{\infty}}%               ∞
\DeclareUnicodeCharacter{219B}{\ensuremath{\nrightarrow}}%         ↛
\DeclareUnicodeCharacter{3C5}{\ensuremath{\upsilon}}%              υ
\DeclareUnicodeCharacter{1D50}{\ensuremath{^m}}%                   ᵐ
\DeclareUnicodeCharacter{2205}{\ensuremath{\emptyset}}%            ∅
\DeclareUnicodeCharacter{3C3}{\ensuremath{\sigma}}%                σ
\DeclareUnicodeCharacter{2254}{\ensuremath{\coloneqq}}%            ≔
\DeclareUnicodeCharacter{2A74}{\ensuremath{\Coloneqq}}%            ⩴
\DeclareUnicodeCharacter{2184}{\ensuremath{\reflectbox{$c$}}}%     ↄ % TODO: \ifmmode
\DeclareUnicodeCharacter{A7FB}{\ensuremath{\reflectbox{$F$}}}%     ꟻ
\DeclareUnicodeCharacter{250}{\ensuremath{\raisebox{\depth}{\rotatebox{180}{a}}}}%   ɐ % TODO: \ifmmode
\DeclareUnicodeCharacter{393}{\ensuremath{\Gamma}}%                Γ
\DeclareUnicodeCharacter{22A2}{\ensuremath{\vdash}}%               ⊢
\DeclareUnicodeCharacter{21AA}{\ensuremath{\hookrightarrow}}%      ↪
\DeclareUnicodeCharacter{2204}{\ensuremath{\nexists}}%             ∄
\DeclareUnicodeCharacter{3C6}{\ensuremath{\phi}}%                  φ
\makeatother
}>>>|)