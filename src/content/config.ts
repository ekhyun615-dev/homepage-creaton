import { defineCollection, z } from 'astro:content';

// 제품(기와) 컬렉션
const products = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    titleEn: z.string().optional(),
    // 카테고리(메인메뉴) — 자유 문자열. 예: '낮은 골기와', '역곡형기와' 등
    category: z.string(),
    categoryOrder: z.number().default(0), // 카테고리 노출 순서
    order: z.number().default(0),         // 카테고리 내 제품 순서
    summary: z.string(),
    image: z.string().optional(),         // 대표 이미지
    // 색상 카드: 이름 + (색상 스와치 hex 또는 이미지)
    colors: z
      .array(
        z.object({
          name: z.string(),
          hex: z.string().optional(),
          image: z.string().optional(),
        })
      )
      .optional(),
    // 규격표: 항목 + 값
    specs: z.array(z.object({ label: z.string(), value: z.string() })).optional(),
    // 시공 사진(슬라이드)
    gallery: z.array(z.string()).optional(),
    draft: z.boolean().default(false),
  }),
});

// 시공 사례 컬렉션
const references = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    location: z.string().optional(),
    buildingType: z.string().optional(),
    product: z.string().optional(),
    image: z.string().optional(),
    // 여러 장의 시공 사진(슬라이드) — 없으면 image 한 장만 표시
    gallery: z.array(z.string()).optional(),
    date: z.string().optional(),
    order: z.number().default(0),
    draft: z.boolean().default(false),
  }),
});

export const collections = { products, references };
